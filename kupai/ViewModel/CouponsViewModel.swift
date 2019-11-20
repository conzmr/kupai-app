//
//  CouponsViewModel.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/18/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class CouponsViewModel {
    
    //var coupons = [Coupon]()
    var coupons:[Coupon] = [Coupon(title: "Descuento en tu próxima visita",
        description: "Consumo mínimo $300",
        expirationDate: "2019-11-18 16:57:29",
        value: 150,
        discountType: "monetary", //percentage
        used: false
    )]
    
}
