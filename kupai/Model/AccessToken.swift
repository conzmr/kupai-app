//
//  AccessToken.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/15/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct AccessToken: Identifiable, Decodable {
    let id: String
    let ttl: Int
    let created: String
    let userId: String
    let user:User?
}
