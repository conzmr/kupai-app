//
//  DayView.swift
//  ScrollingInHorizontalStackView
//
//  Created by Nayem on 4/23/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

import UIKit

protocol CategoryViewDelegate {
    func didCategoryPressed(category:Category)
}

class CategoryView: UIView {

    var category:Category?
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    var delegate: CategoryViewDelegate?
    
    override func draw(_ rect: CGRect) {
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        if let category = self.category {
            categoryName.text = category.name
            categoryImageView.load(url: category.image)
        }
        
        categoryImageView.layer.masksToBounds = false
        categoryImageView.layer.cornerRadius = categoryImageView.frame.height/2
        categoryImageView.layer.borderWidth = 1
        categoryImageView.layer.borderColor = UIColor.clear.cgColor
        categoryImageView.clipsToBounds = true
        
        categoryName.textColor = grayTextColor
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(checkAction))
        self.addGestureRecognizer(gesture)
    }
    

    @objc func checkAction(sender : UITapGestureRecognizer) {
        delegate?.didCategoryPressed(category:self.category!)
    }
    

}
