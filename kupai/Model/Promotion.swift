//
//  Promotion.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/27/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

struct Promotion: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let expirationDate: String
    let active: Bool
    let restaurant: Restaurant
    let branch: Branch
}
