//
//  FeedController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class FeedController: UIViewController {

    struct Promotion {
        var createdAt: String
    }
    @IBOutlet weak var promotionsFeedTableView: UITableView!{
        didSet {
            let nib = UINib(nibName: "FeedPromoCellTableViewCell", bundle: nil)
            promotionsFeedTableView.register(nib, forCellReuseIdentifier: "FeedPromoCellTableViewCellId")
            promotionsFeedTableView.dataSource = self
            promotionsFeedTableView.delegate = self
            promotionsFeedTableView.reloadData()
        }
    }
    @IBOutlet weak var promotiosFeeedTableView: UITableView!
    
    var promotions: [Promotion] = [
        Promotion(createdAt: "2019-09-10 07:20:10"),
        Promotion(createdAt: "2019-09-11 12:45:00"),
        Promotion(createdAt: "2019-09-16 14:28:00"),
        Promotion(createdAt: "2019-09-16 22:19:50"),
        Promotion(createdAt: "2019-09-16 08:09:50"),
        Promotion(createdAt: "2019-09-17 17:29:50"),
    ]
    
    var couponsList = [Coupon](){
        didSet {
            DispatchQueue.main.async {
                self.promotionsFeedTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let couponsRequest = CouponsRequest()
//        couponsRequest.getCoupons{
//            [weak self] result in
//            switch result {
//            case .failure(let error):
//                print("no yuhus")
//                print(error)
//            case .success(let coupons):
//                print("yuhus", coupons)
//                self?.couponsList = coupons
//            }
//        }
        
    }


}

extension FeedController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedPromoCellTableViewCellId", for: indexPath) as! FeedPromoCellTableViewCell
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController
//        vc!.navigationTitle = events[indexPath.section][indexPath.row].eventTransport.rawValue
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }

}
