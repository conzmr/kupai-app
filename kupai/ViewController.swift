//
//  ViewController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 9/25/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: class {
    func finishSigningIn()
    func backToLogin()
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
    ViewControllerDelegate{
    
    //lazy var to access self
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let cellId = "cellId"
    let signupCellId = "signupCellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "Agita tu celular", message: "Con este simple gesto descubre diariamente un cupón nuevo personalizado", imageName: "shakePhone")
        let secondPage  = Page(title: "Busca tus cupones", message: "En tu cuponera quedarán guardados todos los cupones que vayas obteniendo para que los utilices cuando quieras", imageName: "coupons")
        let thirdPage = Page(title: "Canjea tu cupón", message: "Ve a tu restaurante favorito y disfruta una deliciosa comida a un precio promocional", imageName: "eat")
        return[firstPage, secondPage, thirdPage]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = mainColor
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Omitir", for: .normal)
        button.setTitleColor( mainColor, for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()
    
    @objc func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
        //dismiss(animated: true, completion: nil)
    }
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Siguiente", for: .normal)
        button.setTitleColor( mainColor, for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    @objc func nextPage() {
        //we are on the last page
        if pageControl.currentPage == pages.count {
            //dismiss(animated: true, completion: nil)
            return
        }
        
        //second last page
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
       pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        //since they return array of anchors, I need the first, that is top
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first

        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 80, heightConstant: 50).first

        collectionView.frame = view.frame
        //use autolayout instead
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        registerCells()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        //we are on last page
        if pageNumber == pages.count {
            moveControlConstraintsOffScreen()
        } else {
            //back on regular pages
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 30
            nextButtonTopAnchor?.constant = 30
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
    func registerCells(){
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UINib(nibName: "SignupCell", bundle: nil), forCellWithReuseIdentifier: signupCellId)
//        collectionView.register(SignupCell.self, forCellWithReuseIdentifier: signupCellId)
    }
    
    func finishSigningIn() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainTabControllerId")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
//        UserDefaults.standard.setIsLoggedIn(value: true)
        dismiss(animated: true, completion: nil)
    }
    
    func backToLogin() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.item == pages.count){
            let signupCell = collectionView.dequeueReusableCell(withReuseIdentifier: signupCellId, for: indexPath) as! SignupCell
            signupCell.delegate = self
            return signupCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Make cell full screen size
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

}

