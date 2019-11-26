//
//  CategoryViewController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/25/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class CategoryViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    var category:Category?
    var latitude:Double = 0.0
    var longitude:Double = 0.0

    var categoryTitle = "Default"
    
    @IBOutlet weak var promotionsByCategoryTableView: UITableView!{
        didSet {
            let nib = UINib(nibName: "FeedPromoCellTableViewCell", bundle: nil)
            promotionsByCategoryTableView.register(nib, forCellReuseIdentifier: "FeedPromoCellTableViewCellId")
            promotionsByCategoryTableView.dataSource = self
            promotionsByCategoryTableView.delegate = self
            promotionsByCategoryTableView.addSubview(refreshControl)
        }
    }
    
    var promotionVM = PromotionViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.refreshControl.beginRefreshing()
        reloadPromotionsData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category?.name
        reloadPromotionsData()
        refreshControl.addTarget(self, action: #selector(refreshPromotionsData(_:)), for: UIControl.Event.valueChanged)
    }
    
    func reloadPromotionsData(){
        self.refreshControl.beginRefreshing()
        getPromotions()
    }
    
    @objc private func refreshPromotionsData(_ sender: Any) {
        getPromotions()
    }
    
    func getPromotions() {
        //self.refreshControl.beginRefreshing()
        //EN GET PROMOTIONS DEBO PASAR LOS PARÁMETROS
        //IN RELOAD PROMOTIONS DATA ADD OPTIONAL CATEGORY PARAM
        promotionVM.getPromotions(lat: latitude, lng: longitude, completion: { (res) in
            self.refreshControl.endRefreshing()
            switch res {
            case .success(_):
                self.promotionsByCategoryTableView.reloadData()
            case .failure(let err):
                print("ERROR OCURRED GETTING PROMOTIONS BY CATEGORY", err)
            }
        })
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.promotionVM.promotions.count == 0 {
            tableView.setEmptyView(title: "No hay ninguna promoción para la categoría "+categoryTitle, message: "Las promociones disponibles se mostrarán aquí", messageImage: UIImage(named: "discountNoun")!)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PromotionDetailControllerId") as? PromotionDetailController
        vc!.promotion = promotionVM.promotions[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

