//
//  Coupons.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct Coupon:Decodable {
    var title: String
    var description: String
    var expirationDate: String
    var value: Int
    var discountType: String //monetary - percentage
    var used: Bool
    var restaurant: Restaurant?
    var branch: Branch?
}


