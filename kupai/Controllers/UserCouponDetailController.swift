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
           
        
       // setPromotionData()
       // setDetailContainer()
    }
    
//    func setDetailContainer(){
//
//        detailContainer.clipsToBounds = true
//        detailContainer.layer.cornerRadius = 20
//        detailContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
//
//        // border
//        detailContainer.layer.borderWidth = 1.0
//        detailContainer.layer.borderColor = tertiaryColor.cgColor
//
//        // shadow
//        detailContainer.layer.shadowColor = tertiaryColor.cgColor
//        detailContainer.layer.shadowOffset = CGSize(width: 4, height: 4)
//        detailContainer.layer.shadowOpacity = 0.8
//        detailContainer.layer.shadowRadius = 6.0
//    }
    
//    func setPromotionData(){
//        restaurantName = promotion!.restaurant.name
//        self.navigationItem.title = restaurantName
//        branch = promotion!.branch
//        promotionTitle.text = promotion!.title
//        promotionDescription.text = promotion!.description
//        if let expirationDate = promotion?.expirationDate {
//            promotionExpirationDate.text = "Válido hasta "+expirationDate.toDateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", targetFormat: "dd/MM/yyyy")
//        }
//        getImage(url: promotion!.image)
//        updateMap()
//    }
//    
//    func getImage(url: String) {
//           let url = URL(string: url)
//           DispatchQueue.global().async { [weak self] in
//               if let data = try? Data(contentsOf: url!) {
//                   if let image = UIImage(data: data) {
//                       DispatchQueue.main.async {
//                        self!.promotionImage.image = image
//                       }
//                   }
//               }
//           }
//       }
//
//    func updateMap() {
//        if let geopoint = branch?.geolocation {
//            var mapRegion = MKCoordinateRegion()
//            let mapRegionSpan = 0.02
//            mapRegion.center = CLLocationCoordinate2D(latitude: geopoint.lat, longitude: geopoint.lng)
//            mapRegion.span.latitudeDelta = mapRegionSpan
//            mapRegion.span.longitudeDelta = mapRegionSpan
//            guard CLLocationCoordinate2DIsValid(mapRegion.center) else {
//                return
//            }
//            branchMap.setRegion(mapRegion, animated: true)
//            addAnnotationToMap(latitude: geopoint.lat, longitude: geopoint.lng)
//        }
//
//    }
//
//    func addAnnotationToMap(latitude: Double, longitude: Double) {
//        if branchMap.annotations.count > 0 {
//            branchMap.removeAnnotations(branchMap.annotations)
//        }
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        annotation.title = restaurantName
//        let subtitle = "Sucursal  \(branch!.alias) \n" + "Dirección: \(branch!.address)"
//        annotation.subtitle = subtitle
//        branchMap.addAnnotation(annotation)
//    }

    
    

}

