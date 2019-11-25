//
//  BranchesController.swift
//  kupai
//
//  Created by Hermes Espinola on 11/24/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class BranchesController : UIViewController {
    @IBOutlet weak var restaurantLogoImage: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!

    public var logoRawImage: UIImage?
    public var restaurantName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = restaurantName {
            restaurantLabel.text = name
        }
        if let logo = logoRawImage {
            restaurantLogoImage.image = logo
        }
    }
}
