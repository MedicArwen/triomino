//
//  CartManager.swift
//  triomino
//
//  Created by etudiant-16 on 25/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//

import UIKit

class CartManager {
    static var listOfPizza: [Pizza] = []
    static func addPizzaInCart(pizza: Pizza)
    {
        CartManager.listOfPizza.append(pizza)
    }
    static func clearCart()
    {
        CartManager.listOfPizza.removeAll()
    }
    static func count()->Int
    {
        return CartManager.listOfPizza.count
    }
    static func totalPrice()->Int
    {
        var price: Int = 0
        for pizza in listOfPizza
        {
            price += pizza.price
        }
        return price
    }
}
