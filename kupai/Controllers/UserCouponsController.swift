//
//  UserCouponsController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class UserCouponsController: UIViewController {
    struct Coupon {
        var used: Bool
        var expirationDate: Date
        var title: String
        var description: String
    }
}
