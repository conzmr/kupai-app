//
//  AddBranchController.swift
//  kupai
//
//  Created by Hermes Espinola on 11/25/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AddBranchController : UIViewController, MKMapViewDelegate {
    var restaurant: Restaurant!
    @IBOutlet weak var aliasTextField: UITextField!
    @IBOutlet weak var addBranchButton: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let branchesVM = BranchesViewModel()
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var didInitLocation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        print("asd: my restaurant - \(String(describing: restaurant))")
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            print("cosa: Location services enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        if let coord = mapView.userLocation.location?.coordinate {
            initLocation(coord)
            didInitLocation = true
        }

        // setup tap recognizer in map
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(mapTap(_:)))
        longPressGesture.minimumPressDuration = 0.5;
        mapView.addGestureRecognizer(longPressGesture)
    }

    @IBAction func submitRestaurant(_ sender: Any) {
        addBranchButton.loadingIndicator(true)

        let aliasOpt = aliasTextField.text
        let addressOpt = addressTextField.text

        if let name = aliasOpt, let address = addressOpt,
            name != "" && address != "" {
            let geolocation = Geopoint(lng: annotation.coordinate.longitude, lat: annotation.coordinate.latitude)
            branchesVM.createBranch(restaurantId: restaurant.id!, alias: name, address: address, geolocation: geolocation) { res in
                switch res {
                case let .success(branch):
                    print("created restaurant \(branch)")
                    self.showAlert(title: "Sucursal creada!", message: "La sucursal \(name) ha sido creada exitosamente") { _ in
                        self.dismiss(animated: true)
                    }
                case let .failure(error):
                    print(error)
                    self.showAlert(title: "Ups! Algo salió mal", message: error.localizedDescription)
                    self.addBranchButton.loadingIndicator(false)
                }
            }
        } else {
            showAlert(title: "Completa el formulario", message: "Porfavor completa todo el formulario antes de añadir una sucursal.")
            addBranchButton.loadingIndicator(false)
        }
    }

    @objc func mapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if (gestureRecognizer.state == .began) {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let touchCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            print("asd: touch coord: \(touchCoordinate)")
            annotation.coordinate = touchCoordinate
        }
    }

    func initLocation(_ coord: CLLocationCoordinate2D) {
        print("Update location: Location services enabled")
        mapView.setCenter(coord, animated: true)
        annotation.coordinate = coord
        annotation.title = "Ubicación de la sucursal"
        annotation.subtitle = "Ubicación actual"
        mapView.addAnnotation(annotation)
    }
}

extension AddBranchController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if didInitLocation { return }
        if let location = locations.last {
            initLocation(location.coordinate)
            didInitLocation = true
        }
    }
}
