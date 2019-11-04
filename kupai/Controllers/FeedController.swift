//
//  FeedController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class FeedController: UIViewController {
    @IBOutlet weak var promotionsFeedTableView: UITableView!{
        didSet {
            let nib = UINib(nibName: "FeedPromoCellTableViewCell", bundle: nil)
            promotionsFeedTableView.register(nib, forCellReuseIdentifier: "FeedPromoCellTableViewCellId")
            promotionsFeedTableView.dataSource = self
            promotionsFeedTableView.delegate = self
            promotionsFeedTableView.reloadData()
        }
    }
    @IBOutlet weak var promotionsFeeedTableView: UITableView!
    
    @ObservedObject var promotionVM = PromotionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.promotionVM.getPromotions()
    }
}

extension FeedController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.promotionVM.promotions.count
        if numberOfRows == 0 {
            tableView.setEmptyView(title: "No hay ninguna promoción", message: "Las promociones disponibles se mostrarán aquí")
        }
        else {
            tableView.restore()
        }
        return numberOfRows
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
