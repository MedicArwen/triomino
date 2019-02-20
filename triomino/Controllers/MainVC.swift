//
//  ViewController.swift
//  triomino
//
//  Created by Thierry BRU on 23/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
//  C'est la Vue-Controleur principale. Elle permet d'afficher la liste des pizzas commandables.
// Elle est remplie par l'interrogation du Webservice.
//
//  C'est le controleur principal et comme il est à la croisées de tous les autres écrans
// il  gère le panier. Lors du déclanchement de la segue vers DetailPizzaVC, il passe en plus la pizza en cours de commande
// Il gère aussi la liste de pizzas affichées, d'ou l'implémentation de UITableViewDataSource,UITableViewDelegate
//
import UIKit
import Alamofire
import SwiftyJSON

class MainVC: UIViewController {
    // MARK: PROPRIETES DE LA CLASSE
    var listPizzas:[Pizza] = []
    var panierPizzas:Panier = Panier()
    // MARK: OUTLETS FAISANT LE LIEN AVEC LA VUE
    @IBOutlet weak var PizzaListTableVIew: UITableView!
    @IBOutlet weak var buttonCart: UIButton!
    
 
    // MARK: GESTION DES EVENEMENTS DE BASE DE LA VUE-CONTROLEUR
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // MainVC prend en charge la mise à jour de la TableView. Il faut donc le nommer comme delegate
        PizzaListTableVIew.delegate = self
        PizzaListTableVIew.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
     if panierPizzas.count() > 0
     {
        
        if let image = UIImage(named: "cartFull") {
            self.buttonCart.setImage(image, for: .normal)
        }
        }
        else
     {
        if let image = UIImage(named: "cart") {
            self.buttonCart.setImage(image, for: .normal)
        }
        }
        //self.navigationController?.isNavigationBarHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.isNavigationBarHidden = false
    }
    // MARK: GESTION DE LA TRANSITION VERS LES AUTRES VUES-CONTROLEURS
    // Cette méthode s'assure de faire le lien pour les délégués utilisés pour la gestion du panier.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailPizzaVC {
            // Mise en place du lien pour le delegate
            destinationViewController.delegate = self
            let row = PizzaListTableVIew.indexPathForSelectedRow?.row
            let destinationVC = segue.destination as! DetailPizzaVC
            // Passage de la pizza selectionnée et donc à afficher dans la vue détaillée DetailPizzaVC
            destinationVC.PizzaPreparedToBeCommandedInVC = PizzaOrdered(pizzaOrigine:self.listPizzas[row!])
        }
        if let destinationViewController = segue.destination as? CartVC {
            destinationViewController.delegate = self
        }
        
    }
    
    // MARK: METHODES PARTICULIERES A LA CLASSE
    // Cette méthode charge les données depuis le web service et construit la liste des pizzas disponibles
    func getData()
    {
        NetworkManager.sharedInstance.getPizzas { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                let jsonDict = json["pizzas"].dictionaryValue
                for element in jsonDict {
                    let currentPizza = Pizza(json: element.value)
                    self.listPizzas.append(currentPizza)
                }
                self.PizzaListTableVIew.reloadSections([0], with: .automatic)
            }
        }
    }
    @IBAction func onCartButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCart", sender: self)
    }
}
extension MainVC:UITableViewDataSource,UITableViewDelegate
{
    // MARK: IMPLEMENTATION INTERFACE ,UITableViewDataSource,UITableViewDelegate
    // Returns: nombre de cellule Pizza dans la Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPizzas.count
    }
    // Returns: Une cellule Pizza de la Tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PizzaListTableVIew.dequeueReusableCell(withIdentifier: "PizzaViewCell", for: indexPath) as!PizzaViewCell
        cell.updateContent(with: listPizzas[indexPath.row])
        return cell
    }
    // Declenche la segue vers le controleur DetailPizzaVC lors de la selection d'une des pizzas
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPizza", sender: self)
        PizzaListTableVIew.deselectRow(at: indexPath, animated: false)
    }
}
extension MainVC:ICartDelegate
{
    // MARK: Implémentation de l'interface GetCartContentDelegate
    func getCart() -> Panier?
    {
        return panierPizzas
    }
    func clearCart()
    {
        panierPizzas.clearCart()
    }
    func addPizzaInCart(pizzaCommandee: PizzaOrdered)
    {
        panierPizzas.add(pizza: pizzaCommandee)
    }
    func removePizzaInCart(pizzaId: Int)
    {
        panierPizzas.remove(pizzaId: pizzaId)
    }
}

