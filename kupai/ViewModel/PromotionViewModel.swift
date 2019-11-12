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
    
    func getPromotions(completion: @escaping (Result<[Promotion], Error>) -> ()) {
        guard let url = URL(string: getPromotionsURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
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
    }
}
