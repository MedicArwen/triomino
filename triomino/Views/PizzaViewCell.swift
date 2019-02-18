//
//  PizzaViewCell.swift
//  triomino
//
//  Created by Thierry BRU on 24/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
//  Cette vue prend en charge l'affichage des détails d'une pizza dans la tableView de l'écran principal
//

import UIKit
import Alamofire
import AlamofireImage

class PizzaViewCell: UITableViewCell {

    
    // MARK: OUTLETS FAISANT LE LIEN AVEC LA VUE
    @IBOutlet weak var nomPizzaLabel: UILabel!
    @IBOutlet weak var pricePizzaLabel: UILabel!
    @IBOutlet weak var descriptionPizzaTextView: UITextView!
    @IBOutlet weak var pizzaImageView: UIImageView!
    
    // MARK: METHODES GERANT LES EVENEMENTS DE BASE DE LA VUE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateContent(with pizza:Pizza)
    {
        self.nomPizzaLabel.text = pizza.name
        self.descriptionPizzaTextView.text = pizza.description
        self.pricePizzaLabel.text = "\(pizza.price) €"
        self.pizzaImageView.af_setImage(withURL: URL(string: pizza.thumb)!)
        
    }

}
