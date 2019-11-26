//
//  DownloadImage.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 11/26/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

let imageCache = NSCache<NSString, UIImage>()

struct ImageHandler {
   
    static func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(.success(cachedImage))
        } else {
            let urlObj = URL(string: url)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: urlObj!) {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: NSString(string: url))
                        DispatchQueue.main.async {
                            completion(.success(image))
                        }
                    }
                }
            }
        }
    }
}


