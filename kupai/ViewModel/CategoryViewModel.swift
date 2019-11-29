//
//  CategoryViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/24/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class CategoryViewModel {
    
    var categories = [Category]()
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> ()) {
        guard let url = URL(string: getCategoriesURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                if  let error = err {
                    return completion(.failure(error))
                }
                do {
                    self.categories = try JSONDecoder().decode([Category].self, from: data!)
                    completion(.success(self.categories))
                } catch let jsonError {
                    print("Failed to decode JSON:", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
