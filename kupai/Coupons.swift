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
    var expirationDate: Date
    var quantity: Int
    var promoType: String //monetary - percentage
    var used: Bool
}

struct Coupons:Decodable{
    var coupons:[Coupon]
}

struct CouponsResponse:Decodable {
    var response:Coupons
}


