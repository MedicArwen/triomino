//
//  DetailPizzaVC.swift
//  triomino
//
//  Created by Thierry BRU on 24/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
// Ce controleur détaille une pizza et permet de parametrer la commande de cette pizza
// Lors du chargement, il recoit une pizza prête a être commandée avec les parametres par défaut
// Les clics permettent de modifier la pizza en instance de commande, et c'est via le délégué vers MainVC
// qu'il accede au panier pour y inserer cette pizza commandable.


import UIKit

class DetailPizzaVC: UIViewController {
    
    // MARK: PROPRIETES DE LA CLASSE
    var PizzaPreparedToBeCommandedInVC: PizzaOrdered?
    var delegate: ICartDelegate?
    
    // MARK: OUTLETS FAISANT LE LIEN AVEC LA VUE
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var nomPizzaLabel: UILabel!
    @IBOutlet weak var descriptionPizzaText: UITextView!
    @IBOutlet weak var prixPizzaLabel: UILabel!
    @IBOutlet weak var tailleSelectorSC: UISegmentedControl!
    @IBOutlet weak var pateSelectorSC: UISegmentedControl!
    @IBOutlet weak var baseSelectorVC: UISegmentedControl!
    
    // MARK: GESTION DES EVENEMENTS PROPRES AU CONTROLEURS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func updateInfoViewPizzaVC(pizzaToShow: PizzaOrdered) {
        pizzaImageView.af_setImage(withURL: URL(string: pizzaToShow.image)!)
        prixPizzaLabel.text = "\(pizzaToShow.price) €"
        descriptionPizzaText.text = pizzaToShow.description
        nomPizzaLabel.text = pizzaToShow.name
        switch pizzaToShow.base {
        case .Creme:
            baseSelectorVC.selectedSegmentIndex = 0
        case .Tomate:
            baseSelectorVC.selectedSegmentIndex = 1
        case .BBQ:
            baseSelectorVC.selectedSegmentIndex = 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Vérification que la pizza n'a pas été perdue pendant le passage de MainVC à DetailPizzaVC
        // Ca évite les exceptions et les plantages s'il y a eu un soucis.
        if let pizzaToShow = self.PizzaPreparedToBeCommandedInVC
        {
            updateInfoViewPizzaVC(pizzaToShow:pizzaToShow)
        }
    }
    // GESTION DES INTERACTIONS AVEC LES BOUTONS DE LA VUE
    // Cette méthode ajoute la pizza au panier
    @IBAction func onClickAddToCart(_ sender: UIButton) {
        // On s'assure qu'il y a bien une pizza qui est commandable de chargée!
        // Ca évite les exceptions et les plantages s'il y a eu un soucis.
        if let pizzaCommandee = self.PizzaPreparedToBeCommandedInVC
        {
            delegate?.addPizzaInCart(pizzaCommandee: pizzaCommandee)
            let alert : UIAlertController = UIAlertController(title: "AJOUT", message: "1X \(pizzaCommandee.name) ajoutée au panier", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{UIAlertAction in self.navigationController?.popViewController(animated: true)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    // Cette méthode gere la selection d'une nouvelle taille et demande la mise à jour du prix affiché
    @IBAction func onClicSelectSize(_ sender: UISegmentedControl) {
        // On s'assure qu'il y a bien une pizza qui est commandable de chargée!
        // Ca évite les exceptions et les plantages s'il y a eu un soucis.
        if let pizzaCommandee = self.PizzaPreparedToBeCommandedInVC
        {
            switch tailleSelectorSC.selectedSegmentIndex {
            case 0: pizzaCommandee.size = .Medium
            case 1: pizzaCommandee.size = .Large
            default:
                break
            }
            prixPizzaLabel.text = "\(pizzaCommandee.getPrice()) €"
            
        }
    }
    // Cette méthode permet de selectionner un type de pâte
    @IBAction func onClickSelectorPate(_ sender: UISegmentedControl) {
        // On s'assure qu'il y a bien une pizza qui est commandable de chargée!
        // Ca évite les exceptions et les plantages s'il y a eu un soucis.
        if let pizzaCommandee = self.PizzaPreparedToBeCommandedInVC
        {
            switch pateSelectorSC.selectedSegmentIndex {
            case 0: pizzaCommandee.typePate = .Classique
            case 1: pizzaCommandee.typePate = .Fine
            default:
                break
            }
        }}
    // Cette méthode permet de selectionner le type de sauce
    @IBAction func onClickSelectorBaseSauce(_ sender: UISegmentedControl) {
        // On s'assure qu'il y a bien une pizza qui est commandable de chargée!
        // Ca évite les exceptions et les plantages s'il y a eu un soucis.
        if let pizzaCommandee = self.PizzaPreparedToBeCommandedInVC
        {
            switch baseSelectorVC.selectedSegmentIndex {
            case 0: pizzaCommandee.base = .Creme
            case 1: pizzaCommandee.base = .Tomate
            case 2: PizzaPreparedToBeCommandedInVC!.base = .BBQ
            default:
                break
            }
        }
    }
    
    
}
