//
//  UserCouponDetailController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/21/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//


import UIKit
import MapKit

class UserCouponDetailController: UIViewController, MKMapViewDelegate {
    
    var coupon:UserCoupon?
    var branch:Branch?
    
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var branchAlias: UILabel!
    @IBOutlet weak var couponDescription: UILabel!
    @IBOutlet weak var restaurantLogo: UIImageView!
    @IBOutlet weak var couponCode: UILabel!
    
    public var circleY: CGFloat = 0
    public var circleRadius: CGFloat = 0
    @IBOutlet weak var couponContainer: CouponContainerView!
    
//    @IBOutlet weak var couponCroppedContainer: CouponContainerView!
//    @IBOutlet weak var couponMainContainer: UIView!
//
//    @IBOutlet weak var redeemButton: UIButton!
//    
//    @IBOutlet weak var uCouponDetails: UILabel!
//    
//    @IBOutlet weak var uCouponDiscount: UILabel!
//    @IBOutlet weak var uCouponRestaurantName: UILabel!
//    
//    @IBOutlet weak var uCouponBranchName: UILabel!
//    
//    @IBOutlet weak var uCouponDateLabel: UILabel!
//    @IBOutlet weak var uCouponDate: UILabel!
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.clipsToBounds = true
//        couponMainContainer.layer.borderColor = tertiaryColor.cgColor
//        couponMainContainer.layer.borderWidth = 1
//        couponMainContainer.clipsToBounds = true
//        couponMainContainer.layer.cornerRadius = 8.0
//        couponMainContainer.layer.masksToBounds = true
//        
//        couponCroppedContainer.layer.borderWidth = 1
//        couponCroppedContainer.layer.cornerRadius = 8.0
//        couponCroppedContainer.clipsToBounds = true
//        couponCroppedContainer.layer.borderColor = UIColor.white.cgColor
//        couponCroppedContainer.circleRadius = 15
//        couponCroppedContainer.circleY = contentView.frame.height * 0.5
//        
//        redeemButton.backgroundColor = primaryColor
//        redeemButton.setTitleColor(.white, for: .normal)
//        redeemButton.layer.cornerRadius = 3
//        redeemButton.clipsToBounds = true
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        couponContainer.layer.cornerRadius = 8.0
        couponContainer.clipsToBounds = true
        couponContainer.circleRadius = 15
        couponContainer.circleY = couponContainer.frame.height * 0.5
        couponContainer.borderColor = (view?.backgroundColor!.cgColor)!
           
        
       setCouponData()
    }
    
    func setLogoContainer() {
        restaurantLogo.layer.masksToBounds = false
        restaurantLogo.layer.cornerRadius = restaurantLogo.frame.height/2
        restaurantLogo.layer.borderWidth = 1
        restaurantLogo.layer.borderColor = UIColor.clear.cgColor
        restaurantLogo.clipsToBounds = true
    }
    
    
    func setCouponData(){
        
        restaurantName.text = coupon!.restaurant.name
        branchAlias.text = coupon!.branch.alias
        branch = coupon!.branch
        couponCode.text = coupon!.code
        couponDescription.text = coupon!.coupon.details
        
        if coupon!.coupon.discountType == "PERCENTAGE" {
            discountValue.text = String(coupon!.coupon.value)+"%"
        }else{
            discountValue.text = "$"+String(coupon!.coupon.value)
        }
//        if let expirationDate = promotion?.expirationDate {
//            promotionExpirationDate.text = "Válido hasta "+expirationDate.toDateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", targetFormat: "dd/MM/yyyy")
//        }

        ImageHandler.downloadImage(url: coupon!.restaurant.logo, completion: { (res) in
            switch res {
            case .success(let image):
                self.restaurantLogo.image = image
                self.setLogoContainer()
            case .failure(let err):
                print("ERROR OCURRED GETTING IMAGE", err)
            }
        })
    }

}

