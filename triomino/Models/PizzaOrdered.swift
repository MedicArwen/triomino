//
//  PizzaOrdered.swift
//  triomino
//
//  Created by Thierry BRU on 25/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
// La classe PizzaOrdered représente une pizza commandée par l'utilisateur.
// Elle hérite de la classe Pizza et ajoute les options propres à la commande (taille et type de la pâte)
// j'ai fais ce choix pour permettre d'avoir accès à toutes les informations directement aux données de la classe mère
// On peut ainsi si l'on veut, afficher la photo de la pizza. C'est discutable dans le sens ou ce n'est pas demandé dans l'exo
// et cela entraine une plus grande consommation mémoire. D'un autre coté cela permet de manipuler l'héritage et les constructeurs

import Foundation
class PizzaOrdered: Pizza
{
    // MARK: Propriétés de la classe
    var size: Size
    var typePate: TypePate

    // MARK: Constructeurs de la classe
    /// Constructeur de base de la classe PizzaOrdered
    /// - Parameters:
    ///     - pizzaOrigine: Pizza servant de base à la pizza commandée
    ///     - nase: sauce de base (creme fraiche, sauce tomate ou sauce barbecue) choisie par la personne qui commande
    ///     - size: taille de la pizza choisiée par la personne qui passe commande
    ///     - pate: type de la pâte choisie par la personne qui passe commande
    init(pizzaOrigine: Pizza,base: BaseSauce, size: Size, pate: TypePate) {
        self.size = size
        self.typePate = pate
        super.init(base:base.rawValue, description: pizzaOrigine.description, image: pizzaOrigine.image, name: pizzaOrigine.name, price: pizzaOrigine.price, thumb: pizzaOrigine.thumb)
        
    }
    /// Constructeur secondaire de la classe PizzaOrdered: il prend une pizza de base et la configure avec les options par défaut
    /// - Parameters:
    ///     - pizzaOrigine: Pizza servant de base à la pizza commandée
   convenience init(pizzaOrigine: Pizza)
    {
        self.init(pizzaOrigine: pizzaOrigine, base: pizzaOrigine.base, size: .Medium, pate: .Classique)
    }
    // MARK: Methodes propres à la classe
    /// Returns une chaine de caractère représentant la liste des options choisies pour cette pizza commandée
    func printOption()->String
    {
        return "\(self.base.rawValue), pâte \(self.typePate.rawValue), taille \(self.size.rawValue)"
    }
    // returns le prix de la pizza commandée en fonction des options choisies (il n'y a que la taille qui change le prix)
    func getPrice()->Double
    {
        if self.size == .Large
        {return 2.0 + self.price}
        else
        {return self.price}
    }
}
