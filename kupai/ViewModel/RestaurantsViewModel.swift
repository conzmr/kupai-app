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

}

