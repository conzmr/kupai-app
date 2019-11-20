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
    
    @objc private func refreshCouponsData(_ sender: Any) {
        getCoupons()
    }
    
    func getCoupons() {
        print("Get coupons")
        self.refreshControl.endRefreshing()
//        couponsVM.getUserCoupons(completion: { (res) in
//               self.refreshControl.endRefreshing()
//               switch res {
//               case .success(_):
//                   self.promotionsFeedTableView.reloadData()
//               case .failure(let err):
//                   print("ERROR OCURRED GETTING PROMOTIONS", err)
//               }
//           })
    }
    
}


extension UserCouponsController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.couponsVM.coupons.count == 0 {
            tableView.setEmptyView(title: "No tienes cupones", message: "Agita tu celular para obtener tu primer cupón", messageImage: .actions)
        }
        else {
            tableView.restore()
        }
        return self.couponsVM.coupons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCouponTableViewCellId", for: indexPath) as! UserCouponTableViewCell
        let coupon: Coupon
        coupon = self.couponsVM.coupons[indexPath.row]
        //cell.title.text = coupon.title
        //cell.restaurantName.text = promotion.restaurant.name
//        cell.getImage(url: promotion.restaurant.logo, cellImage: cell.restaurantLogo)
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 170
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "PromotionDetailControllerId") as? PromotionDetailController
//        vc!.coupon = couponsVM.coupons[indexPath.row]
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
}

