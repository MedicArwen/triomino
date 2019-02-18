//
//  Panier.swift
//  triomino
//
//  Created by Thierry BRU on 25/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
// Cette classe représente le panier de pizzas commandées. Il consiste en une liste de pizzas.

import Foundation
class Panier
{
    // MARK: PROPRIETES DE LA CLASSE
    private var pizzas: [PizzaOrdered]
    
    // MARK: CONSTRUCTEUR DE LA CLASSE
    init() {
        self.pizzas = []
    }
    // MARK: METHODES PROPRES A LA CLASSE
    
    /// Returns le prix total de la commande de pizzas en fonction des options pour chaque pizzas
    func calculPrix()->Int
    {
        var prix = 0
        for pizza in pizzas
        {
            prix += pizza.getPrice()
        }
        return prix
    }
    // Cette méthode permet d'ajouter une pizza au panier
    func add(pizza: PizzaOrdered)
    {
        self.pizzas.append(pizza)
    }
    // Cette méthode permet de retirer une pizza du panier
    func remove(pizzaId: Int)
    {
        self.pizzas.remove(at: pizzaId)
    }
    // Returns: retourne la liste des pizzas contenues dans le panier
    func getPizzaList()->[PizzaOrdered]
    {
        return self.pizzas
    }
    /// Returns la pizza selectionnée dans le panier
    /// - Parameters
    ///     - pizzaId: identifiant de la pizza que l'on veut récupérer
    func getPizzaById(pizzaId: Int)->PizzaOrdered
    {
        return self.pizzas[pizzaId]
    }
    
    // Cette méthode permet de vider le panier totalement.
    func clearCart()
    {
        self.pizzas.removeAll()
    }
}
