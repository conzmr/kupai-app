//
//  UserViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/3/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class UserViewModel{
    
    var user:User?
    var token:Token?
    
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
                let token = try JSONDecoder().decode(Token.self, from: data!)
                self.token = token
                self.user = token.user
                self.saveUserSession()
                completion(.success(token.user))
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
                let token = try JSONDecoder().decode(Token.self, from: data!)
                self.token = token
                self.user = token.user
                self.saveUserSession()
                completion(.success(token.user))
            }catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    func logoutUser(completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let url = URL(string: logoutURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
            self.removeUserSession()
        }.resume()
    }
    
    func removeUserSession(){
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    func saveUserSession() {
        UserDefaults.standard.set(token?.id, forKey: "token")
        UserDefaults.standard.set(user?.id, forKey: "userId")
        UserDefaults.standard.set(user?.email, forKey: "email")
        //hacer un if let de user.name si no viene no se settea
        UserDefaults.standard.set(user?.name ?? "Carlos Santana", forKey: "name")
        UserDefaults.standard.set(user?.type, forKey: "userType")
        UserDefaults.standard.synchronize()
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.object(forKey: "token") != nil
    }

    func isUserType(_ type: String) -> Bool {
        if let userType = UserDefaults.standard.string(forKey: "userType") {
            return type == userType
        } else {
            return false
        }
    }
}

