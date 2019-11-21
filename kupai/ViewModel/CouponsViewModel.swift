//
//  CouponsViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/18/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class CouponsViewModel {
    
    var userCoupons = [UserCoupon]()
    var userCoupon:UserCoupon?
    
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
    
    func getDailyCoupon(lat:Double, lng: Double, completion: @escaping (Result<UserCoupon, Error>) -> ()) {
        if let token = UserDefaults.standard.string(forKey: "token") {
            guard let url = URL(string: getDailyCouponURL(lat: lat, lng: lng, token: token)) else { return }
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                DispatchQueue.main.async {
                    if  let error = err {
                        return completion(.failure(error))
                    }
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("data: \(dataString)")
                    }
                    do {
                        self.userCoupon = try JSONDecoder().decode(UserCoupon.self, from: data!)
                        completion(.success(self.userCoupon!))
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
    
}
