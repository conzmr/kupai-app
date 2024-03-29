//
//  UserCouponTableViewCell.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/19/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

protocol UserCouponTableViewCellDelegate {
    func didRedeemButtonPressed(userCoupon:UserCoupon)
}

class UserCouponTableViewCell: UITableViewCell {


    public var circleY: CGFloat = 0
    public var circleRadius: CGFloat = 0
    
    var userCoupon:UserCoupon?
    var delegate: UserCouponTableViewCellDelegate?
    
    @IBOutlet weak var couponCroppedContainer: CouponContainerView!
    @IBOutlet weak var couponMainContainer: UIView!

    @IBOutlet weak var redeemButton: UIButton!
    
    @IBOutlet weak var uCouponDetails: UILabel!
    
    @IBOutlet weak var uCouponDiscount: UILabel!
    @IBOutlet weak var uCouponRestaurantName: UILabel!
    
    @IBOutlet weak var uCouponBranchName: UILabel!
    
    @IBOutlet weak var uCouponDateLabel: UILabel!
    @IBOutlet weak var uCouponDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        couponMainContainer.layer.borderColor = tertiaryColor.cgColor
        couponMainContainer.layer.borderWidth = 1
        couponMainContainer.clipsToBounds = true
        couponMainContainer.layer.cornerRadius = 8.0
        couponMainContainer.layer.masksToBounds = true
        
        couponCroppedContainer.layer.borderWidth = 1
        couponCroppedContainer.layer.cornerRadius = 8.0
        couponCroppedContainer.clipsToBounds = true
        couponCroppedContainer.layer.borderColor = UIColor.white.cgColor
        couponCroppedContainer.circleRadius = 15
        couponCroppedContainer.circleY = contentView.frame.height * 0.5
        
        redeemButton.backgroundColor = primaryColor
        redeemButton.setTitleColor(.white, for: .normal)
        redeemButton.layer.cornerRadius = 3
        redeemButton.clipsToBounds = true
        
    }

    @IBAction func showUserCouponDetail(_ sender: Any) {
        delegate?.didRedeemButtonPressed(userCoupon:userCoupon!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
    }
    
}
