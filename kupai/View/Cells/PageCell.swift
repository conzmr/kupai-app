//
//  PageCell.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 9/26/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet{
            guard let page = page else{
                return
            }
            imageView.image = UIImage(named: page.imageName)
            let color = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .yellow
        iv.image = UIImage(named:"shakePhone")
        iv.clipsToBounds = false
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Text For Now"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    func setupViews(){
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        //If you want the image end up at the top of text view
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        //imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
//        textView.anchorToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
