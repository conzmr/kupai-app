//
//  PromotionDetailController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/12/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit
import MapKit

class PromotionDetailController: UIViewController, MKMapViewDelegate {
    
    var promotion:Promotion?
    var branch:Branch?
    @IBOutlet weak var promotionTitle: UILabel!
    
    @IBOutlet weak var promotionDescription: UILabel!
    
    @IBOutlet weak var promotionExpirationDate: UILabel!
    @IBOutlet weak var detailContainer: UIView!
    
    @IBOutlet weak var branchMap: MKMapView!
    
    var restaurantName = ""

    @IBOutlet weak var promotionImage: UIImageView!
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                promotionImage.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                promotionImage.addConstraint(aspectConstraint!)
            }
        }
    }
    
    @IBOutlet weak var imageConstraintHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aspectConstraint = nil
        self.navigationItem.largeTitleDisplayMode = .never
        
        setPromotionData()
        setDetailContainer()
    }
    
    func setDetailContainer(){
        
        detailContainer.clipsToBounds = true
        detailContainer.layer.cornerRadius = 20
        detailContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively

        // border
        detailContainer.layer.borderWidth = 1.0
        detailContainer.layer.borderColor = tertiaryColor.cgColor

        // shadow
        detailContainer.layer.shadowColor = tertiaryColor.cgColor
        detailContainer.layer.shadowOffset = CGSize(width: 4, height: 4)
        detailContainer.layer.shadowOpacity = 0.8
        detailContainer.layer.shadowRadius = 6.0
    }
    
    func setPromotionData(){
        restaurantName = promotion!.restaurant.name
        self.navigationItem.title = restaurantName
        branch = promotion!.branch
        promotionTitle.text = promotion!.title
        promotionDescription.text = promotion!.description
        if let expirationDate = promotion?.expirationDate {
            promotionExpirationDate.text = "Válido hasta "+expirationDate.toDateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", targetFormat: "dd/MM/yyyy")
        }
        ImageHandler.downloadImage(url: promotion!.image, completion: { (res) in
            switch res {
            case .success(let image):
                self.promotionImage.image = image
                self.setCustomImage(image: image)
            case .failure(let err):
                print("ERROR OCURRED GETTING IMAGE", err)
            }
        })
        updateMap()
    }
    
    func setCustomImage(image : UIImage) {
        
        let aspect = image.size.width / image.size.height
        
        let constraint = NSLayoutConstraint(item: promotionImage as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: promotionImage, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        
        aspectConstraint = constraint
        
        promotionImage.image = image
    }

    func updateMap() {
        if let geopoint = branch?.geolocation {
            var mapRegion = MKCoordinateRegion()
            let mapRegionSpan = 0.02
            mapRegion.center = CLLocationCoordinate2D(latitude: geopoint.lat, longitude: geopoint.lng)
            mapRegion.span.latitudeDelta = mapRegionSpan
            mapRegion.span.longitudeDelta = mapRegionSpan
            guard CLLocationCoordinate2DIsValid(mapRegion.center) else {
                return
            }
            branchMap.setRegion(mapRegion, animated: true)
            addAnnotationToMap(latitude: geopoint.lat, longitude: geopoint.lng)
        }
        
    }

    func addAnnotationToMap(latitude: Double, longitude: Double) {
        if branchMap.annotations.count > 0 {
            branchMap.removeAnnotations(branchMap.annotations)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = restaurantName
        let subtitle = "Sucursal  \(branch!.alias) \n" + "Dirección: \(branch!.address)"
        annotation.subtitle = subtitle
        branchMap.addAnnotation(annotation)
    }

    
    

}
