//
//  UserCouponsController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class UserCouponsController: UIViewController {
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var couponsTableView: UITableView!{
        didSet {
            let nib = UINib(nibName: "UserCouponTableViewCell", bundle: nil)
            couponsTableView.register(nib, forCellReuseIdentifier: "UserCouponTableViewCellId")
            couponsTableView.dataSource = self
            couponsTableView.delegate = self
            couponsTableView.addSubview(refreshControl)
        }
    }
    var couponsVM = CouponsViewModel()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.refreshControl.beginRefreshing()
            getCoupons()
            refreshControl.addTarget(self, action: #selector(refreshCouponsData(_:)), for: UIControl.Event.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.refreshControl.beginRefreshing()
         getCoupons()
    }
    
    @objc private func refreshCouponsData(_ sender: Any) {
        getCoupons()
    }
    
    func getCoupons() {
        couponsVM.getUserCoupons(completion: { (res) in
               self.refreshControl.endRefreshing()
               switch res {
               case .success(_):
                   self.couponsTableView.reloadData()
               case .failure(let err):
                   print("ERROR OCURRED GETTING USER COUPONS", err)
            }
        })
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("HUBO UN TAKI SHAKI EN USER COUPONS VC")
            let latitude:Double = UserDefaults.standard.double(forKey: "latitude")
            let longitude:Double = UserDefaults.standard.double(forKey: "longitude")
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
    
}


extension UserCouponsController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.couponsVM.userCoupons.count == 0 {
            tableView.setEmptyView(title: "No tienes cupones", message: "Agita tu celular para obtener tu primer cupón", messageImage: UIImage(named: "nounCoupon")!)
        }
        else {
            tableView.restore()
        }
        return self.couponsVM.userCoupons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCouponTableViewCellId", for: indexPath) as! UserCouponTableViewCell
        let uCoupon = self.couponsVM.userCoupons[indexPath.row]
        let coupon = uCoupon.coupon
        let restaurant = uCoupon.restaurant
        let branch = uCoupon.branch
        
        cell.userCoupon = uCoupon
        
        cell.uCouponDetails.text = coupon.details
        cell.uCouponRestaurantName.text = restaurant.name
        cell.uCouponBranchName.text = branch.alias
        if(coupon.discountType == "PERCENTAGE"){
            cell.uCouponDiscount.text = String(coupon.value)+"%"
        }else{
            cell.uCouponDiscount.text = "$"+String(coupon.value)
        }
        
        if let reedemedAt = uCoupon.redeemedAt {
            cell.redeemButton.isHidden = true
            cell.uCouponDateLabel.text = "Redimido"
            cell.uCouponDate.text = reedemedAt.toDateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", targetFormat: "dd/MM/yyyy")
        }
        else{
            if coupon.expirationDate.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") <= Date() {
                cell.uCouponDateLabel.text = "Expiró"
                cell.redeemButton.isHidden = true
            }else{
                cell.uCouponDateLabel.text = "Expira"
            }
            cell.uCouponDate.text = coupon.expirationDate.toDateString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", targetFormat: "dd/MM/yyyy")
        }
        cell.delegate = self
        return cell
    }
}

extension UserCouponsController:UserCouponTableViewCellDelegate {

    func didRedeemButtonPressed(userCoupon:UserCoupon) {
          print("AQUÍ EN EL DELEGATE")
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserCouponDetailControllerId") as? UserCouponDetailController
          vc!.coupon = userCoupon
          self.navigationController?.pushViewController(vc!, animated: true)
      }

}
