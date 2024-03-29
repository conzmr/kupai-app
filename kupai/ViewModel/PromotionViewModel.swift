//
//  PromotionViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/2/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class PromotionViewModel {
    
    var promotions = [Promotion]()
    var promotionsByCategory = [Promotion]()
    
    func getPromotionsByCategory(lat:Double, lng: Double, category:String, completion: @escaping (Result<[Promotion], Error>) -> ()) {
            if let token = UserDefaults.standard.string(forKey: "token") {
                   guard let url = URL(string: getPromotionsByCategoryURL(lat:lat, lng:lng, category:category, token: token)) else { return }
                     URLSession.shared.dataTask(with: url) { (data, resp, err) in
                         DispatchQueue.main.async {
                             if  let error = err {
                                 return completion(.failure(error))
                             }
                             do {
                                 self.promotionsByCategory = try JSONDecoder().decode([Promotion].self, from: data!)
                                 completion(.success(self.promotionsByCategory))
                             } catch let jsonError {
                                 print("Failed to decode JSON:", jsonError)
                                 completion(.failure(jsonError))
                             }
                         }
                     }.resume()
            } else {
               print("LAT", lat)
               print("NO LAT, LNG OR TOKEN")
            }
        }
    
    func getPromotions(lat:Double, lng: Double, completion: @escaping (Result<[Promotion], Error>) -> ()) {
        if let token = UserDefaults.standard.string(forKey: "token") {
               guard let url = URL(string: getPromotionsURL(lat:lat, lng:lng, token: token)) else { return }
                 URLSession.shared.dataTask(with: url) { (data, resp, err) in
                     DispatchQueue.main.async {
                         if  let error = err {
                             return completion(.failure(error))
                         }
                         do {
                             self.promotions = try JSONDecoder().decode([Promotion].self, from: data!)
                             completion(.success(self.promotions))
                         } catch let jsonError {
                             print("Failed to decode JSON:", jsonError)
                             completion(.failure(jsonError))
                         }
                     }
                 }.resume()
        }else{
           print("LAT", lat)
           print("NO LAT, LNG OR TOKEN")
        }
    }
}
