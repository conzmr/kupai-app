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
    
//    var branchLatitude = 0.0
//    var branchLongitude = 0.0
//    var branchAlias = ""
//
//    var eventName = ""
//    var eventDate = Date()
//    var event : NSManagedObject!
//    @IBOutlet weak var eventDetailMap: MKMapView!
    
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
        self.setCustomImage(image: promotionImage.image!)
    //    self.navigationItem.title = title
//        updateMap()
    }
    
    func setCustomImage(image : UIImage) {
        
        let aspect = image.size.width / image.size.height
        
        let constraint = NSLayoutConstraint(item: promotionImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: promotionImage, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        
        aspectConstraint = constraint
        
        promotionImage.image = image
    }
    
//    func getEventProperties(){
//        eventName = event.value(forKey: "name") as! String
//        eventLatitude = event.value(forKey: "latitude") as! Double
//        eventLongitude = event.value(forKey: "longitude") as! Double
//        eventDate = event.value(forKey: "date") as! Date
//    }
//
//
//    func updateMap() {
//        if (eventLatitude == 0.0 && eventLongitude == 0.0){
//            return
//        }
//        var mapRegion = MKCoordinateRegion()
//        let mapRegionSpan = 0.02
//        mapRegion.center = CLLocationCoordinate2D(latitude: eventLatitude, longitude: eventLongitude)
//        mapRegion.span.latitudeDelta = mapRegionSpan
//        mapRegion.span.longitudeDelta = mapRegionSpan
//        guard CLLocationCoordinate2DIsValid(mapRegion.center) else {
//            return
//        }
//        eventDetailMap.setRegion(mapRegion, animated: true)
//        addAnnotationToMap(latitude: eventLatitude, longitude: eventLongitude)
//    }
//
//    func addAnnotationToMap(latitude: Double, longitude: Double) {
//        if eventDetailMap.annotations.count > 0 {
//            eventDetailMap.removeAnnotations(eventDetailMap.annotations)
//        }
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        annotation.title = eventName
//        let subtitle = "Fecha: \(eventDate.toString(withFormat: "E MMM d, yyyy")) \n" + "Hora: \(eventDate.toString(withFormat: "h:mm a"))"
//        annotation.subtitle = subtitle
//        eventDetailMap.addAnnotation(annotation)
//    }

    
    

}
