//
//  User.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct User: Identifiable,Codable {
    var id: String
    var type: String
    var email: String
    var name: String?
    var createdAt: String
}

struct Token: Codable {
    var id: String
    var ttl: Int
    var userId: String
    var created: String
    var user: User
}
