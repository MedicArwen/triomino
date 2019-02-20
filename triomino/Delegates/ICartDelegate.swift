//
//  AddInCartDelegate.swift
//  triomino
//
//  Created by Thierry BRU on 15/02/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
//  Cette interface permet de définir les méthodes à implémenter sur le controleur MainVC.
//  Ce contrôleur est le chef d'orchestre qui s'assure de la mise à jour du panier.
// Les vues DetailPizzaVC et CartVC appellent des méthodes implémentés sur MainVC pour manipuler le panier.
// L'interface permet de s'assurer qu'il y a bien les bonnes méthodes implémentées sur le controleur
protocol ICartDelegate
{
    func addPizzaInCart(pizzaCommandee: PizzaOrdered)
    func removePizzaInCart(pizzaId: Int)
    func getCart()->Panier?
    func clearCart()
}
