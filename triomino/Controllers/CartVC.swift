//
//  ViewController.swift
//  triomino
//
//  Created by Thierry BRU on 23/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
//  Ce controleur prend en charge l'affichage du panier dans son intégralité.
//  Il utilise le delegate pour accéder au panier via la méthode getCart() implémentée sur MainVC.
//  C'est rendu intéressant par la centralité de MainVC.
//  Une tableview gere l'affichage des pizzas commandées.

import UIKit


class CartVC: UIViewController{
    
    // MARK: PROPRIETES DE LA CLASSE
    var delegate: ICartDelegate?
    //var panierPizza: Panier?
    // MARK: OUTLETS FAISANT LE LIEN AVEC LA VUE ASSOCIEE AU CONTROLEUR
    @IBOutlet weak var pizzaListTableView: UITableView!
    @IBOutlet weak var labelPrixAddition: UILabel!
    @IBOutlet weak var labelVIde: UILabel!
    @IBOutlet weak var boutonCommander: UIButton!
    
    // MARK: GESTION DES EVENEMENTS PROPRES AU CONTROLEURS
    override func viewDidLoad() {
        super.viewDidLoad()
        // CartVC prend en charge la mise à jour de la TableView. Il faut donc le nommer comme delegate
        pizzaListTableView.delegate = self
        pizzaListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if let panierPizza = self.delegate!.getCart()
        {
            labelPrixAddition.text = "\(panierPizza.calculPrix()) €"
        }
        else
        {
            labelPrixAddition.text = "0 €"
        }
        checkIfCartEmpty()
        boutonCommander.layer.cornerRadius = 5
        boutonCommander.layer.borderWidth = 2
        boutonCommander.layer.borderColor = UIColor.white.cgColor
    }
    // Passage des informations lors du déclenchement du segue par le click sur le bouton Commander
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? InfoCustomerVC {
            // Il faut donner au controleur suivant l'acces via un delegate au controleur MainVC
            destinationViewController.delegate = self.delegate
        
        }
        
    }
    // Cette méthode permet d'activer et desactiver le bouton et cacher ou non le texte "VIDE" suivant le contenu du panier
    fileprivate func checkIfCartEmpty() {
        if delegate!.getCart()!.count() == 0
        {
            self.labelVIde.isHidden = false
            boutonCommander.isEnabled = false
        }
        else
        {
            self.labelVIde.isHidden = true
            boutonCommander.isEnabled = true
        }
    }
    
    

    
    
    // MARK GESTION EVENEMENTS SUR LA VUE
    // Cette méthode gere le click sur "vider" pour effacer tout ce qu'il y a dans le pannier.
    @IBAction func onClickTrashClearCart(_ sender: UIButton)
    {
        print("Click Pour vider le panier, il y a \(String(describing: self.delegate?.getCart()!.getPizzaList().count)) pizzas dans le panier.")
        pizzaListTableView.reloadSections([0], with: .automatic)
        let alert : UIAlertController = UIAlertController(title: "Vider le pannier", message: "Voulez-vous supprimer le contenu de votre panier?", preferredStyle: UIAlertController.Style.alert)
        // PAS BON ON A CHANGE DE NAVIGATION CONTROLEUR, IL FAUT RECHARGER LE PREMIER AVEC LE CATALOGUE DE PIZZA
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Supprimer", style: .default, handler:{UIAlertAction in
            (
                self.delegate!.clearCart(),
                self.labelPrixAddition.text = "0 €",// forcément vide le panier!
                self.labelVIde.isHidden = false, // forcément vide le panier!
                self.boutonCommander.isEnabled = false,// forcément vide le panier!
                self.pizzaListTableView.reloadSections([0], with: .automatic)
            )
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func clickOnCommander(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToValidate", sender: self)
    }
    
}
extension CartVC: UITableViewDataSource,UITableViewDelegate
{
    // MARK: IMPLEMENTATION INTERFACE ,UITableViewDataSource,UITableViewDelegate
    // Returns: nombre de cellule Pizza dans la Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate!.getCart()!.getPizzaList().count
    }
    
    // Returns: Une cellule Pizza de la Tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pizzaListTableView.dequeueReusableCell(withIdentifier: "PizzaCartViewCell", for: indexPath) as!PizzaPanierViewCell
        cell.updateContent(with:  delegate!.getCart()!.getPizzaById(pizzaId: indexPath.row))
        return cell
    }
    
    // Permet de supprimer une des pizzas du panier par un swift.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            self.delegate!.removePizzaInCart(pizzaId: indexPath.row)
            self.labelPrixAddition.text = "\(String(describing: self.delegate!.getCart()!.calculPrix())) €"
            self.pizzaListTableView.reloadSections([0], with: .automatic)
        }
    }
}

