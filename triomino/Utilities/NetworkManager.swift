//
//  NetworkController.swift
//  triomino
//
//  Created by Thierry BRU on 24/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
//  Cette structure permet d'appeler le Web Service
//

import Foundation
import Alamofire
import SwiftyJSON

// Singleton pour l'appel réseau

typealias ServiceResponse = ((JSON?, Error?) -> Void)

struct NetworkManager {
    
    let endPoint = "http://triominos.000webhostapp.com/CDSM/triominosAPI/pizzas.json"
    static let sharedInstance = NetworkManager()
    fileprivate init() {}
    
    func getPizzas(_ completion: @escaping ServiceResponse) {
        
        Alamofire.request(endPoint, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("## SUCCESSFULLY RECEIVED JSON DATAS ##")
                    //print("## -> DATA received = \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
