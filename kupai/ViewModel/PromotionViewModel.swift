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
    
    func getPromotions(lat:Double, lng: Double, completion: @escaping (Result<[Promotion], Error>) -> ()) {
        if let token = UserDefaults.standard.string(forKey: "token") {
               guard let url = URL(string: getPromotionsURL(lat:lat, lng:lng, token: token)) else { return }
                 URLSession.shared.dataTask(with: url) { (data, resp, err) in
                     DispatchQueue.main.async {
                         if  let error = err {
                             return completion(.failure(error))
                         }
                         if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                             print("data: \(dataString)")
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
