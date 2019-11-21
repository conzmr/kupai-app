//
//  FeedController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

class FeedController: UIViewController {
    private let refreshControl = UIRefreshControl()
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var address:String = ""
    
    @IBOutlet weak var promotionsFeedTableView: UITableView!{
        didSet {
            let nib = UINib(nibName: "FeedPromoCellTableViewCell", bundle: nil)
            promotionsFeedTableView.register(nib, forCellReuseIdentifier: "FeedPromoCellTableViewCellId")
            promotionsFeedTableView.dataSource = self
            promotionsFeedTableView.delegate = self
            promotionsFeedTableView.addSubview(refreshControl)
        }
    }
    @IBOutlet weak var promotionsFeeedTableView: UITableView!
    
    var promotionVM = PromotionViewModel()
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    override func viewWillAppear(_ animated: Bool) {
        reloadPromotionsData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a navView to add to the navigation bar
       // let navView = UIView()
//
//        let label = UILabel()
//        label.text = "Text fhjdsakl"
//        label.sizeToFit()
//        label.center = navView.center
//        label.textAlignment = NSTextAlignment.left
//
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 12, height: view.frame.height))
//        label.text = "Mi ubicación actual"
//        label.sizeToFit()
//        label.textColor = UIColor.black
//        label.textAlignment = NSTextAlignment.left
//        //label.center = navView.center
//        label.font = UIFont.systemFont(ofSize: 17)
////
////        // Create the image view
//        let image = UIImageView()
//        image.image = UIImage(named: "locationPin")
//        // To maintain the image's aspect ratio:
//        let imageAspect = image.image!.size.width/image.image!.size.height
//        // Setting the image frame so that it's immediately before the text:
//        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
//        image.contentMode = UIView.ContentMode.scaleAspectFit
//
//        // Add both the label and image view to the navView
//        navView.addSubview(label)
//        navView.addSubview(image)
//
//         //Set the navView's frame to fit within the titleView
       // navView.sizeToFit()
//
//        // Set the navigation bar's navigation item's titleView to the navView/
       // self.navigationItem.titleView = navView

        //Location manager set up
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        getCurrentLocation()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        reloadPromotionsData()
        refreshControl.addTarget(self, action: #selector(refreshPromotionsData(_:)), for: UIControl.Event.valueChanged)
    }
    
    func setNavigationLabelText(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width , height: view.frame.height))
        titleLabel.text = address
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        navigationItem.titleView = titleLabel
    }
    
    func getFeedRequestLocation(){
        let slatitude:Double? = UserDefaults.standard.double(forKey: "latitude")
        let slongitude:Double? = UserDefaults.standard.double(forKey: "longitude")
        let saddress:String? = UserDefaults.standard.string(forKey: "address")
        if(slatitude == 0.0 || slongitude == 0.0 || saddress == nil){
            getCurrentLocation()
        }else{
            latitude = slatitude!
            longitude = slongitude!
            address = saddress!
            setNavigationLabelText()
        }
    }
    
    func reloadPromotionsData(){
        getFeedRequestLocation()
        self.refreshControl.beginRefreshing()
        getPromotions()
    }
    
    @objc private func refreshPromotionsData(_ sender: Any) {
        getPromotions()
    }
    
    func getPromotions() {
        //EN GET PROMOTIONS DEBO PASAR LOS PARÁMETROS
        promotionVM.getPromotions(completion: { (res) in
            self.refreshControl.endRefreshing()
            switch res {
            case .success(_):
                self.promotionsFeedTableView.reloadData()
            case .failure(let err):
                print("ERROR OCURRED GETTING PROMOTIONS", err)
            }
        })
    }
    
    func getCurrentLocation() {
           let status = CLLocationManager.authorizationStatus()
        
           if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
               return
           }

           if(status == .notDetermined){
               locationManager.requestWhenInUseAuthorization()
           }
           
           locationManager.requestLocation()
       }
}

extension FeedController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.promotionVM.promotions.count == 0 {
            tableView.setEmptyView(title: "No hay ninguna promoción", message: "Las promociones disponibles se mostrarán aquí", messageImage: UIImage(named: "discountNoun")!)
        }
        else {
            tableView.restore()
        }
        return self.promotionVM.promotions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedPromoCellTableViewCellId", for: indexPath) as! FeedPromoCellTableViewCell
        let promotion: Promotion
        promotion = self.promotionVM.promotions[indexPath.row]
        cell.title.text = promotion.title
        cell.getImage(url: promotion.image, cellImage: cell.promoImage)
        cell.restaurantName.text = promotion.restaurant.name
        cell.getImage(url: promotion.restaurant.logo, cellImage: cell.restaurantLogo)
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 170
//    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PromotionDetailControllerId") as? PromotionDetailController
        vc!.promotion = promotionVM.promotions[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension FeedController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.first {
            currentLocation = current
            latitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
            address = "Usar mi ubicación actual"
            //print("location:: \(current)")
            setNavigationLabelText()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            //do this ?locationManager.requestLocation()
            print("When in use")
        case .denied:
            print("Denied")
        case .notDetermined:
            print("Not determined")
        default:
            print("Other case")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
