//
//  RestaurantsViewModel.swift
//  kupai
//
//  Created by Hermes Espinola on 11/20/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class RestaurantsViewModel {
    
    var userCoupons = [UserCoupon]()
    var restaurants = [Restaurant]()
    
    func getUserCoupons(completion: @escaping (Result<[UserCoupon], Error>) -> ()) {
        if let userId = UserDefaults.standard.string(forKey: "userId"),
            let token = UserDefaults.standard.string(forKey: "token") {
            guard let url = URL(string: getUserCouponsURL(userId: userId, token: token)) else { return }
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                DispatchQueue.main.async {
                    if  let error = err {
                        return completion(.failure(error))
                    }
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("data: \(dataString)")
                    }
                    do {
                        self.userCoupons = try JSONDecoder().decode([UserCoupon].self, from: data!)
                        completion(.success(self.userCoupons))
                    } catch let jsonError {
                        print("Failed to decode JSON:", jsonError)
                        completion(.failure(jsonError))
                    }
                }
            }.resume()
        }else{
            //Implement custom error here
           print("NO USERID OR TOKEN")
        }
        
    }

    func getAllRestaurant(completion: @escaping (Result<[Restaurant], Error>) -> ()) {
        // TODO: filter by name?
        guard let url = URL(string: getRestaurantsURL(filter: nil)) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                if let error = err {
                    return completion(.failure(error))
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
                do {
                    self.restaurants = try JSONDecoder().decode([Restaurant].self, from: data!)
                    completion(.success(self.restaurants))
                } catch let jsonError {
                    print("Failed to decode JSON:", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func createRestaurant(name: String, logo: String, completion: @escaping (Result<Restaurant, Error>) -> ()) {
        guard let url = URL(string: createRestaurantURL) else { print("[createRestaurant] invaild url"); return }
        var request = URLRequest(url: url)
        let parameters = ["name": name, "logo": logo]
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            do {
                let restaurant = try JSONDecoder().decode(Restaurant.self, from: data!)
                completion(.success(restaurant))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

