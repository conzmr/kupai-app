//
//  FeedPromoCellTableViewCell.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class FeedPromoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContainer.layer.borderColor = tertiaryColor.cgColor
        cellContainer.layer.borderWidth = 1
        cellContainer.layer.cornerRadius = 5
        cellContainer.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
