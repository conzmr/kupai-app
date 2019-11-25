//
//  Category.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/23/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

struct Category: Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let image: String
    
    /// Init
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
