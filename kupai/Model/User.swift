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
    var userId: String
    var email: String?
    var name: String?
    var created: String
}
