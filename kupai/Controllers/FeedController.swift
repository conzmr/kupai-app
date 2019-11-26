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

class FeedController: UIViewController, LocationControllerDelegate {
    private let refreshControl = UIRefreshControl()
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var address:String = ""
    
    @IBOutlet weak var categoriesContainer: UIScrollView!
    @IBOutlet weak var categoriesHScrollableStackView: UIStackView!
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
    var couponsVM = CouponsViewModel()
    var categoryVM = CategoryViewModel()
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    func setCategories() {
        for category in categoryVM.categories {
            if let categoryView = Bundle.main.loadNibNamed("CategoryView", owner: nil, options: nil)!.first as? CategoryView {
                categoryView.delegate = self
                categoryView.category = category
                categoriesHScrollableStackView.addArrangedSubview(categoryView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VER SI TENGO ALGO EN LOCAL STORAGE, ESO USO Y HAGO MI REQUEST, SI NO, BUSCO MI UBICACIÓN ACTUAL POR DEFAULT
        getCategories()
        
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
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()

        getFeedRequestLocation()
        refreshControl.addTarget(self, action: #selector(refreshPromotionsData(_:)), for: UIControl.Event.valueChanged)
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            couponsVM.getDailyCoupon(lat: latitude, lng: longitude, completion: { (res) in
                //AÑADIR ALGÚN TIPO DE ACTIVITY CONTROL??
                switch res {
                    case .success(let userCoupon):
                        print("SUCCESS GETTING DAILY COUPON", userCoupon)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserCouponDetailControllerId") as? UserCouponDetailController
                        vc!.coupon = userCoupon
                        self.navigationController?.pushViewController(vc!, animated: true)
                    case .failure(let err):
                        self.showAlert(title: "No hay cupones disponibles", message: "Por favor intenta más tarde")
                        print("ERROR OCURRED GETTING DAILY COUPON", err)
                    }
                })
        }
    }
    
    func setNavigationLabelText(address: String){
        self.address = address
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width , height: view.frame.height))
        titleLabel.text = address
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        navigationItem.titleView = titleLabel
    }
    
    func getFeedRequestLocation(){
        self.refreshControl.beginRefreshing()
        let slatitude:Double? = UserDefaults.standard.double(forKey: "latitude")
        let slongitude:Double? = UserDefaults.standard.double(forKey: "longitude")
        let saddress:String? = UserDefaults.standard.string(forKey: "address")
        if(slatitude == 0.0 || slongitude == 0.0 || saddress == nil){
            setNavigationLabelText(address: "Usar mi ubicación actual")
            getCurrentLocation()
        }else{
            self.latitude = slatitude!
            self.longitude = slongitude!
            setNavigationLabelText(address:saddress!)
            getPromotions()
        }
    }
    
    func reloadPromotionsData(latitude: Double, longitude: Double, address: String){
        self.refreshControl.beginRefreshing()
        self.latitude = latitude
        self.longitude = longitude
        setNavigationLabelText(address:address)
        getPromotions()
    }
    
    @objc private func refreshPromotionsData(_ sender: Any) {
        getPromotions()
    }
    
    @IBAction func searchLocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationSearchViewControllerId") as? LocationSearchViewController
        vc!.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func getPromotions() {
        //EN GET PROMOTIONS DEBO PASAR LOS PARÁMETROS
        promotionVM.getPromotions(lat: latitude, lng: longitude, completion: { (res) in
            self.refreshControl.endRefreshing()
            switch res {
            case .success(_):
                self.promotionsFeedTableView.reloadData()
            case .failure(let err):
                print("ERROR OCURRED GETTING PROMOTIONS", err)
            }
        })
    }
    
    func getCategories() {
        categoryVM.getCategories(completion: { (res) in
            self.refreshControl.endRefreshing()
            switch res {
            case .success(_):
                self.setCategories()
            case .failure(let err):
                print("ERROR OCURRED GETTING CATEGORIES", err)
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
        ImageHandler.downloadImage(url: promotion.image, completion: { (res) in
            switch res {
            case .success(let image):
                cell.promoImage.image = image
            case .failure(let err):
                print("ERROR OCURRED GETTING IMAGE", err)
            }
        })
        //cell.getImage(url: promotion.image, cellImage: cell.promoImage)
        cell.restaurantName.text = promotion.restaurant.name
        ImageHandler.downloadImage(url: promotion.restaurant.logo, completion: { (res) in
            switch res {
            case .success(let image):
                cell.restaurantLogo.image = image
            case .failure(let err):
                print("ERROR OCURRED GETTING IMAGE", err)
            }
        })
        //cell.restaurantLogo.image = ImageHandler.downloadImage(url: promotion.restaurant.logo)
        //cell.getImage(url: promotion.restaurant.logo, cellImage: cell.restaurantLogo)
        return cell
    }

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
            saveCurrentLocation(latitude: latitude, longitude: longitude)
            //print("location:: \(current)")
            setNavigationLabelText(address: "Usar mi ubicación actual")
            getPromotions()
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
    
    func saveCurrentLocation(latitude: Double, longitude: Double) {
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
        UserDefaults.standard.synchronize()
    }
}

extension FeedController: CategoryViewDelegate {

    func didCategoryPressed(category:Category) {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewControllerId") as? CategoryViewController
          vc!.category = category
          vc!.latitude = latitude
          vc!.longitude = longitude
          self.navigationController?.pushViewController(vc!, animated: true)
      }
}

protocol LocationControllerDelegate: class {
    func reloadPromotionsData(latitude: Double, longitude: Double, address: String)
    func getCurrentLocation()
}
