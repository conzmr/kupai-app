//
//  Constants.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/6/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

let mainColor =  UIColor(red: 255/255, green: 80/255, blue: 80/255, alpha: 1)

//Needed division because constructor receives decimals
//private for constants
//let primaryColor = UIColor(red: 56/255, green: 117/255, blue: 233/255, alpha: 1)
//let secondaryColor = UIColor(red: 173/255, green: 202/255, blue: 250/255, alpha: 1)

let primaryColor = UIColor(red: 255/255, green: 94/255, blue: 97/255, alpha: 1)
let secondaryColor = UIColor(red: 255/255, green: 94/255, blue: 97/255, alpha: 0.2)
let tertiaryColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
let quaternaryColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 0.2)


//API
let baseApiURL = "https://kupai.herokuapp.com/api/"


//ROUTES

//USER
let authenticateURL = baseApiURL+"AppUsers/login?include=User"
let createUserURL = baseApiURL+"AppUsers"
let logoutURL = baseApiURL+"AppUsers/logout"

//PROMOTIONS
let getPromotionsURL = baseApiURL+"Promotions?filter=%7B%22include%22%3A%20%5B%7B%22relation%22%3A%20%22branch%22%7D%2C%20%7B%22relation%22%3A%20%22restaurant%22%7D%5D%7D"

//COUPONS
func getUserCouponsURL(userId: String, token: String) -> String {
    return baseApiURL+"AppUsers/\(userId)/coupons?filter=%7B%22order%22%3A%20%22createdAt%20DESC%22%2C%20%22include%22%3A%20%5B%20%7B%22relation%22%3A%20%22coupon%22%7D%2C%20%7B%22relation%22%3A%20%22branch%22%7D%2C%20%7B%22relation%22%3A%20%22restaurant%22%7D%5D%7D&access_token=\(token)"
}

// RESTAURANTS
func getRestaurantsURL(filter: String?) -> String {
    if let filter = filter?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        return baseApiURL + "Restaurants?filter=\(filter)"
    }

    return baseApiURL + "Restaurants"
}
