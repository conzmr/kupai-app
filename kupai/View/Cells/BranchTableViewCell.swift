//
//  BranchTableViewCell.swift
//  kupai
//
//  Created by Hermes Espinola on 11/25/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class BranchTableViewCell : UITableViewCell {
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContainer.clipsToBounds = true
    }
}
