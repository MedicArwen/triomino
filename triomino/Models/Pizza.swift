//
//  pizza.swift
//  triomino
//
//  Created by Thierry BRU on 23/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
// La classe représente une Pizza, avec les données chargées depuis le Web Service.
// Elle ne contient pas les informations subsidiaires liées à des options commandées

import Foundation
import SwiftyJSON

class Pizza
{
    // MARK: PROPRIETES DE LA CLASSE
    var base: BaseSauce
    var description: String
    var image: String
    var name: String
    var price: Int
    var thumb: String
    // MARK: CONSTRUCTEURS DE LA CLASSE
    
    /// Constructeur de base de la classe Pizza
    /// - Parameters:
    ///     - base: sauce de base (creme fraiche, sauce tomate ou sauce barbecue
    ///     - image: photo taille grande de la pizza
    ///     - name: nom de la pizza
    ///     - price: prix de base de la pizza, hors options (taille medium par défaut)
    ///     - thumb: image en taille réduire de la pizza
    init(base: String, description: String, image: String, name: String, price: Int, thumb: String) {
        self.base = Pizza.convertSauceStringToEnum(nomSauce: base)
        self.description = description
        self.image = image
        self.name = name
        self.price = price
        self.thumb = thumb
    }
    /// Constructeur secondaire de la classe Pizza
    /// - Parameters:
    ///     - json: object JSON récupéré du web service
    convenience init(json: JSON)
    {
        self.init(base:json["base"].stringValue,description:json["description"].stringValue,
                  image:json["image"].stringValue, name:json["name"].stringValue,
                  price:json["price"].intValue,thumb:json["thumb"].stringValue)
        
    }
    // MARK: METHODES DE LA CLASSE
    /// returns la chaine de caractere décrivant la sauce dans la réponse du web service sous forme d'un élément BaseSauce (enum)
    /// - Parameters:
    ///     - nomSauce: nom de la sauce en texte version longue venant du webservice
    ///
    static func convertSauceStringToEnum(nomSauce: String)->BaseSauce
    {
        var sauceEnum:BaseSauce = .Tomate
        switch nomSauce {
        case "Sauce tomate":
            sauceEnum = .Tomate
        case "Sauce Barbecue":
            sauceEnum = .BBQ
        case "Crème fraîche":
            sauceEnum = .Creme
        default:
            break
        }
        return sauceEnum
    }
}

