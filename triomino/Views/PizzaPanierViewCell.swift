//
//  PizzaPanierViewCell.swift
//  triomino
//
//  Created by Thierry BRU on 24/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
//  Cette vue prend en charge l'affichage des détails d'une pizza dans la tableView de l'écran Panier
//


import UIKit

class PizzaPanierViewCell: UITableViewCell {
    // MARK: OUTLETS FAISANT LE LIEN AVEC LA VUE
    @IBOutlet weak var descriptionPizzaTexView: UITextView!
    @IBOutlet weak var nomPizzaLabel: UILabel!
    @IBOutlet weak var pricePizzaLabel: UILabel!
    // MARK: METHODES GERANT LES EVENEMENTS DE BASE DE LA VUE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateContent(with pizza:PizzaOrdered)
    {
        self.nomPizzaLabel.text = pizza.name
        self.descriptionPizzaTexView.text = pizza.printOption()
        self.pricePizzaLabel.text = "\(pizza.getPrice()) €"
        
        
    }

}
