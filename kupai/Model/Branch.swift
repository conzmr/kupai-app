//
//  Branch.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/18/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

struct Branch: Decodable {
    let alias: String
    let address: String
    let geolocation: Geopoint
    let city: String?
    let country: String?
    let restaurantId: String
    let restaurant: Restaurant?
}

struct Geopoint: Codable {
    let lng: Double
    let lat: Double
}
