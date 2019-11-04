//
//  Promotion.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/27/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct Promotion:Identifiable,Decodable {
    var id: String
    var title: String
    var description: String
    var image: String
    var expirationDate: Date
    var active: Bool
}
