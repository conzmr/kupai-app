//
//  PromotionViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/2/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class PromotionViewModel: ObservableObject {
    
    @Published var promotions = [Promotion]()
    
    func getPromotions() {
        guard let url = URL(string: getPromotionsURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                do {
                    self.promotions = try JSONDecoder().decode([Promotion].self, from: data!)
                } catch {
                    print("Failed to decode JSON:", error)
                }
            }
        }.resume()
    }
}
