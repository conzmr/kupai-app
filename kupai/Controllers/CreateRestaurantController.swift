//
//  CreateRestaurantController.swift
//  kupai
//
//  Created by Hermes Espinola on 11/24/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class CreateRestaurantController : UIViewController {
    @IBOutlet weak var restaurantNameInput: UITextField!
    @IBOutlet weak var restaurantLogoInput: UITextField!
    @IBOutlet weak var addRestaurantButton: UIButton!

    var restaurantsVM = RestaurantsViewModel()

    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func submitRestaurant(_ sender: Any) {
        addRestaurantButton.loadingIndicator(true)

        let nameOpt = restaurantNameInput.text
        let logoUrlOpt = restaurantLogoInput.text

        if let name = nameOpt, let logoUrl = logoUrlOpt, name != "" && logoUrl != "" {
            if let _ = URL.init(string: logoUrl) {
                restaurantsVM.createRestaurant(name: name, logo: logoUrl) { res in
                    switch res {
                    case let .success(restaurant):
                        print("created restaurant \(restaurant)")
                        self.showAlert(title: "Restaurante creado!", message: "El restaurante \(name) ha sido creado exitosamente") { _ in
                            self.dismiss(animated: true)
                        }
                    case let .failure(error):
                        self.showAlert(title: "Ups! Algo salió mal", message: error.localizedDescription)
                        self.addRestaurantButton.loadingIndicator(false)
                    }
                }
            } else {
                showAlert(title: "Porfavor usa un URL valido", message: "Link al logo debe de ser un URL valido")
                addRestaurantButton.loadingIndicator(false)
            }
        } else {
            showAlert(title: "Completa el formulario", message: "Porfavor completa todo el formulario antes de añadir un restaurante.")
            addRestaurantButton.loadingIndicator(false)
        }
    }
}
