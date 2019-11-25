//
//  RestaurantCell.swift
//  kupai
//
//  Created by Hermes Espinola on 11/21/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class RestaurantTableViewCell : UITableViewCell {

    @IBOutlet public weak var restaurantLogo: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var cellContainer: UIView!

    var buttonAction: ((Any) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContainer.layer.borderColor = tertiaryColor.cgColor
        cellContainer.layer.borderWidth = 1
        cellContainer.layer.cornerRadius = 5
        cellContainer.clipsToBounds = true

        restaurantLogo.layer.masksToBounds = false
        restaurantLogo.layer.cornerRadius = restaurantLogo.frame.height/2
        restaurantLogo.layer.borderWidth = 1
        restaurantLogo.layer.borderColor = UIColor.clear.cgColor
        restaurantLogo.clipsToBounds = true
    }
    
    @objc func buttonPressed(sender: Any) {
        self.buttonAction?(sender)
    }
}
