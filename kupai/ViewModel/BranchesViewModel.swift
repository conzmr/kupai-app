//
//  BranchesViewModel.swift
//  kupai
//
//  Created by Hermes Espinola on 11/25/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

class BranchesViewModel {
    var branches = [Branch]()

    func getBranches(restaurantId: String, completion: @escaping (Result<[Branch], Error>) -> ()) {
        guard let url = URL(string: getBranchesURL(filter: "{\"where\": {\"restaurantId\":\"\(restaurantId)\"}}")) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                if let error = err {
                    return completion(.failure(error))
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
                do {
                    self.branches = try JSONDecoder().decode([Branch].self, from: data!)
                    completion(.success(self.branches))
                } catch let jsonError {
                    print("Failed to decode JSON:", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }


    struct EncodableBranch: Encodable {
        let alias: String
        let address: String
        let geolocation: Geopoint
        let restaurantId: String
        let location: Location
    }

    struct Location: Encodable {
        let type: String
        let coordinates: [Double]
    }

    func createBranch(restaurantId: String, alias: String, address: String, geolocation: Geopoint, completion: @escaping (Result<Branch, Error>) -> ()) {
        guard let url = URL(string: branchesURL) else { return }
        var request = URLRequest(url: url)
        let branch = EncodableBranch(
            alias: alias,
            address: address,
            geolocation: geolocation,
            restaurantId: restaurantId,
            location: Location(type: "Point", coordinates: [geolocation.lng, geolocation.lat])
        )
        print(branch)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(branch)
            request.httpBody = data
        } catch let error {
            print(error)
            completion(.failure(error))
        }

        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            do {
                let branch = try JSONDecoder().decode(Branch.self, from: data!)
                completion(.success(branch))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
