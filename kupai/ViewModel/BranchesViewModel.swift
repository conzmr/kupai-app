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
}
