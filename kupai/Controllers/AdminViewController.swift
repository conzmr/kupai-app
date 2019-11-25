//
//  AdminViewController.swift
//  kupai
//
//  Created by Hermes Espinola on 11/20/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class AdminViewController : UIViewController {
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var restaurantTable: UITableView! {
        didSet {
            let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
            restaurantTable.register(nib, forCellReuseIdentifier: "RestaurantCellTableViewCellId")
            restaurantTable.dataSource = self
            restaurantTable.delegate = self
            restaurantTable.addSubview(refreshControl)
        }
    }
    let restaurantsVM = RestaurantsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.beginRefreshing()
        getRestaurants()
        refreshControl.addTarget(self, action: #selector(refreshRestaurantsData(_:)), for: UIControl.Event.valueChanged)
    }

    @objc private func refreshRestaurantsData(_ sender: Any) {
        getRestaurants()
    }

    func getRestaurants() {
        restaurantsVM.getAllRestaurant() { res in
            self.refreshControl.endRefreshing()
            switch res {
            case .success(_):
                self.restaurantTable.reloadData()
            case .failure(let err):
                print("ERROR OCURRED GETTING USER COUPONS", err)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBranchList" {
            let indexPath = sender as! IndexPath
            let selectedRestaurant = restaurantsVM.restaurants[indexPath.row]
            let branchList = segue.destination as! BranchesController

            // Set restaurant info in branch view
            branchList.restaurantName = selectedRestaurant.name
            let selectedCell = restaurantTable.cellForRow(at: indexPath) as! RestaurantTableViewCell
            branchList.logoRawImage = selectedCell.restaurantLogo.image
        }
    }
}

extension AdminViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.restaurantsVM.restaurants.count == 0 {
            // TODO: Change image
            tableView.setEmptyView(title: "No hay restaurantes", message: "Haz clic en + para agregar un restaurante", messageImage: UIImage(named: "nounCoupon")!)
        }
        else {
            tableView.restore()
        }

        return self.restaurantsVM.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCellTableViewCellId", for: indexPath) as! RestaurantTableViewCell
        let restaurant = self.restaurantsVM.restaurants[indexPath.row]
        cell.getImage(url: restaurant.logo, cellImage: cell.restaurantLogo)
        cell.restaurantName.text = restaurant.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToBranchList", sender: indexPath)
    }
}
