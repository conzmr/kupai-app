//
//  CouponsRequest.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import Foundation

//Error protocol
enum CouponError:Error {
    case noDataAvailable
    case canNotProcessData
}
struct CouponsRequest {
    let resourceURL: URL
    
    init(){
        let resourceString = "https://kupai.herokuapp.com/api/Coupons"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    
    func getCoupons(completion: @escaping(Result<[Coupon], CouponError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            print("Data res", data)
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                print("coupons response self", CouponsResponse.self)
                print("JSON DATA", jsonData)
                let couponsResponse = try decoder.decode(CouponsResponse.self, from: jsonData)
                let coupons = couponsResponse.response.coupons
                completion(.success(coupons))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
