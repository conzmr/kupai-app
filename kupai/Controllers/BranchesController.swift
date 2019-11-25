//
//  BranchesController.swift
//  kupai
//
//  Created by Hermes Espinola on 11/24/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class BranchesController : UIViewController {
    @IBOutlet weak var restaurantLogoImage: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var branchesTable: UITableView!

    public var logoRawImage: UIImage?
    public var restaurant: Restaurant!

    let branchesVM = BranchesViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "BranchTableViewCell", bundle: nil)
        branchesTable.register(nib, forCellReuseIdentifier: "BranchTableViewCellId")
        branchesTable.addSubview(refreshControl)
        branchesTable.dataSource = self
        branchesTable.delegate = self

        restaurantLabel.text = restaurant.name
        if let logo = logoRawImage {
            restaurantLogoImage.image = logo
        }

        getBranches()
        refreshControl.addTarget(self, action: #selector(refreshBranchData(_:)), for: UIControl.Event.valueChanged)
    }

    @objc private func refreshBranchData(_ sender: Any) {
        getBranches()
    }

    func getBranches() {
        self.refreshControl.beginRefreshing()
        branchesVM.getBranches(restaurantId: restaurant.id) { res in
            self.refreshControl.endRefreshing()
            switch res {
            case .success(_):
                self.branchesTable.reloadData()
            case let .failure(jsonError):
                print("[BranchesController:getBranches]", jsonError)
            }
        }
    }
}

extension BranchesController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.branchesVM.branches.count
        if count == 0 {
            // TODO: Change image
            tableView.setEmptyView(title: "No hay sucursales", message: "Haz clic en + para agregar una sucursal", messageImage: UIImage(named: "nounCoupon")!)
        }
        else {
            tableView.restore()
        }

        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchTableViewCellId", for: indexPath) as! BranchTableViewCell
        let branch = self.branchesVM.branches[indexPath.row]

        cell.aliasLabel.text = branch.alias
        cell.addressLabel.text = branch.address
        return cell
    }
}
