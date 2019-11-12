//
//  FeedController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class FeedController: UIViewController {
    private let refreshControl = UIRefreshControl()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.beginRefreshing()
        getPromotions()
        refreshControl.addTarget(self, action: #selector(refreshPromotionsData(_:)), for: UIControl.Event.valueChanged)
    }
    
    @objc private func refreshPromotionsData(_ sender: Any) {
        getPromotions()
    }
    
    func getPromotions() {
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
}

extension FeedController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.promotionVM.promotions.count == 0 {
            tableView.setEmptyView(title: "No hay ninguna promoción", message: "Las promociones disponibles se mostrarán aquí", messageImage: .actions)
        }
        else {
            tableView.restore()
        }
        print("number", self.promotionVM.promotions.count)
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
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController
//        vc!.navigationTitle = events[indexPath.section][indexPath.row].eventTransport.rawValue
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }

}
