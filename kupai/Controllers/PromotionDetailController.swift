//
//  PromotionDetailController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/12/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class PromotionDetailController : UIViewController {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    var branchLatitude = 0.0
    var branchLongitude = 0.0
    var branchAlias = ""
    var eventName = ""
    var eventDate = Date()

    @IBOutlet weak var promotionImage: UIImageView!

}

extension PromotionDetailController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}


//  // Present the Autocomplete view controller when the button is pressed.
//  @objc func autocompleteClicked(_ sender: UIButton) {
//    let autocompleteController = GMSAutocompleteViewController()
//    autocompleteController.delegate = self
//
//    // Specify the place data types to return.
//    let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//      UInt(GMSPlaceField.placeID.rawValue))!
//    autocompleteController.placeFields = fields
//
//    // Specify a filter.
//    let filter = GMSAutocompleteFilter()
//    filter.type = .address
//    autocompleteController.autocompleteFilter = filter
//
//    // Display the autocomplete view controller.
//    present(autocompleteController, animated: true, completion: nil)
//  }
//
//  // Add a button to the view.
//  func makeButton() {
//    let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
//    btnLaunchAc.backgroundColor = .blue
//    btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
//    btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
//    self.view.addSubview(btnLaunchAc)
//  }
//
//}
//
//extension PromotionDetailController: GMSAutocompleteViewControllerDelegate {
//
//  // Handle the user's selection.
//  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//    print("Place name: \(place.name)")
//    print("Place ID: \(place.placeID)")
//    print("Place attributions: \(place.attributions)")
//    dismiss(animated: true, completion: nil)
//  }
//
//  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//    // TODO: handle the error.
//    print("Error: ", error.localizedDescription)
//  }
//
//  // User canceled the operation.
//  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//    dismiss(animated: true, completion: nil)
//  }
//
//  // Turn the network activity indicator on and off again.
//  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//  }
//
//  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//  }
//
//}

//class PromotionDetailController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//
//  // You don't need to modify the default init(nibName:bundle:) method.
//
//  override func loadView() {
//    // Create a GMSCameraPosition that tells the map to display the
//    // coordinate -33.86,151.20 at zoom level 6.
//    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//    view = mapView
//
//    // Creates a marker in the center of the map.
//    let marker = GMSMarker()
//    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//    marker.title = "Sydney"
//    marker.snippet = "Australia"
//    marker.map = mapView
//  }
//}

//class PromotionDetailController: UIViewController {
//
//  override func viewDidLoad() {
//    makeButton()
//  }
//
//  // Present the Autocomplete view controller when the button is pressed.
//  @objc func autocompleteClicked(_ sender: UIButton) {
//    let autocompleteController = GMSAutocompleteViewController()
//    autocompleteController.delegate = self
//
//    // Specify the place data types to return.
//    let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//      UInt(GMSPlaceField.placeID.rawValue))!
//    autocompleteController.placeFields = fields
//
//                // Specify a filter.
//    let filter = GMSAutocompleteFilter()
//    filter.type = .address
//    autocompleteController.autocompleteFilter = filter
//
//    // Display the autocomplete view controller.
//    present(autocompleteController, animated: true, completion: nil)
//  }
//
//  // Add a button to the view.
//  func makeButton() {
//    let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
//    btnLaunchAc.backgroundColor = .blue
//    btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
//    btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
//    self.view.addSubview(btnLaunchAc)
//  }
//
//}
//
//extension PromotionDetailController: GMSAutocompleteViewControllerDelegate {
//
//  // Handle the user's selection.
//  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//    print("Place name: \(place.name)")
//    print("Place ID: \(place.placeID)")
//    print("Place attributions: \(place.attributions)")
//    dismiss(animated: true, completion: nil)
//  }
//
//  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//    // TODO: handle the error.
//    print("Error: ", error.localizedDescription)
//  }
//
//  // User canceled the operation.
//  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//    dismiss(animated: true, completion: nil)
//  }
//
//  // Turn the network activity indicator on and off again.
//  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//  }
//
//  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//  }
//
//}

//
//
//class PromotionDetailController: UIViewController, MKMapViewDelegate {
//
////    var branchLatitude = 0.0
////    var branchLongitude = 0.0
////    var branchAlias = ""
////
////    var eventName = ""
////    var eventDate = Date()
////    var event : NSManagedObject!
////    @IBOutlet weak var eventDetailMap: MKMapView!
//
//    @IBOutlet weak var promotionImage: UIImageView!
//
//    internal var aspectConstraint : NSLayoutConstraint? {
//        didSet {
//            if oldValue != nil {
//                promotionImage.removeConstraint(oldValue!)
//            }
//            if aspectConstraint != nil {
//                promotionImage.addConstraint(aspectConstraint!)
//            }
//        }
//    }
//
//    @IBOutlet weak var imageConstraintHeight: NSLayoutConstraint!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        aspectConstraint = nil
//        self.setCustomImage(image: promotionImage.image!)
//    //    self.navigationItem.title = title
////        updateMap()
//    }
//
//    func setCustomImage(image : UIImage) {
//
//        let aspect = image.size.width / image.size.height
//
//        let constraint = NSLayoutConstraint(item: promotionImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: promotionImage, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
//        constraint.priority = UILayoutPriority(rawValue: 999)
//
//        aspectConstraint = constraint
//
//        promotionImage.image = image
//    }
//
////    func getEventProperties(){
////        eventName = event.value(forKey: "name") as! String
////        eventLatitude = event.value(forKey: "latitude") as! Double
////        eventLongitude = event.value(forKey: "longitude") as! Double
////        eventDate = event.value(forKey: "date") as! Date
////    }
////
////
////    func updateMap() {
////        if (eventLatitude == 0.0 && eventLongitude == 0.0){
////            return
////        }
////        var mapRegion = MKCoordinateRegion()
////        let mapRegionSpan = 0.02
////        mapRegion.center = CLLocationCoordinate2D(latitude: eventLatitude, longitude: eventLongitude)
////        mapRegion.span.latitudeDelta = mapRegionSpan
////        mapRegion.span.longitudeDelta = mapRegionSpan
////        guard CLLocationCoordinate2DIsValid(mapRegion.center) else {
////            return
////        }
////        eventDetailMap.setRegion(mapRegion, animated: true)
////        addAnnotationToMap(latitude: eventLatitude, longitude: eventLongitude)
////    }
////
////    func addAnnotationToMap(latitude: Double, longitude: Double) {
////        if eventDetailMap.annotations.count > 0 {
////            eventDetailMap.removeAnnotations(eventDetailMap.annotations)
////        }
////        let annotation = MKPointAnnotation()
////        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
////        annotation.title = eventName
////        let subtitle = "Fecha: \(eventDate.toString(withFormat: "E MMM d, yyyy")) \n" + "Hora: \(eventDate.toString(withFormat: "h:mm a"))"
////        annotation.subtitle = subtitle
////        eventDetailMap.addAnnotation(annotation)
////    }
//
//
//
//
//}
