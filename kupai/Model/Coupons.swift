//
//  Coupons.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct Coupon:Decodable {
    var details: String
    var expirationDate: String
    var value: Int
    var discountType: String //monetary - percentage
    var active: Bool
    var restaurant: Restaurant?
    var branch: Branch?
    var available: Int
}

struct UserCoupon:Decodable {
    var redeemedAt: String?
    var coupon: Coupon
    var restaurant: Restaurant
    var branch: Branch
}


