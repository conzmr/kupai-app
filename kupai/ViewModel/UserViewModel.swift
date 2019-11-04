//
//  UserViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/3/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var user:User?
    
    func authenticateUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        guard let url = URL(string: authenticateURL) else { return }
        var request = URLRequest(url: url)
        let parameters = ["email": email, "password": password]
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            do{
                self.user = try JSONDecoder().decode(User.self, from: data!)
                self.user!.email = email
                completion(.success(self.user!))
            }catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func createUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        guard let url = URL(string: createUserURL) else { return }
        var request = URLRequest(url: url)
        let parameters = ["email": email, "password": password]
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("data: \(dataString)")
            }
            do{
                let user = try JSONDecoder().decode(User.self, from: data!)
                self.user = user
                completion(.success(user))
            }catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    //FUNCTION TO SET DATA IN USER DEFAULTS
    
}

