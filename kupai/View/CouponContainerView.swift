//
//  CouponContainerView.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/19/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

public class CouponContainerView: UIView {

    private let leftCircle = UIView(frame: .zero)
    private let rightCircle = UIView(frame: .zero)

    public var circleY: CGFloat = 0
    public var circleRadius: CGFloat = 0

    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(leftCircle)
        addSubview(rightCircle)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        addSubview(leftCircle)
        addSubview(rightCircle)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        leftCircle.backgroundColor = superview?.backgroundColor
        leftCircle.layer.borderColor = tertiaryColor.cgColor
        leftCircle.layer.borderWidth = 1
        leftCircle.frame = CGRect(x: -circleRadius, y: circleY,
                                  width: circleRadius * 2 , height: circleRadius * 2)
        leftCircle.layer.masksToBounds = true
        leftCircle.layer.cornerRadius = circleRadius
        leftCircle.layer.zPosition = 0

        rightCircle.backgroundColor = superview?.backgroundColor
        rightCircle.layer.borderColor = tertiaryColor.cgColor
        rightCircle.layer.borderWidth = 1
        rightCircle.frame = CGRect(x: bounds.width - circleRadius, y: circleY,
                                   width: circleRadius * 2 , height: circleRadius * 2)
        rightCircle.layer.masksToBounds = true
        rightCircle.layer.cornerRadius = circleRadius
    }
}
