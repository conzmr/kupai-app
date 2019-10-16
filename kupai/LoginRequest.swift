//
//  LoginRequest.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct LoginRequest {
    let resourceURL: URL
    
    init(email: String, password: String){
        let resourceString = "https://kupai.herokuapp.com/api/AppUsers/login"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    

}
