//
//  InfoCustomerVC.swift
//  triomino
//
//  Created by Thierry BRU on 25/01/2019.
//  Copyright © 2019 Networked Hells. All rights reserved.
//
// Ce controleur gere la saisie des informations pour expédier la commande à la bonne personne.
//
//
//

import UIKit

class InfoCustomerVC: UIViewController, UITextFieldDelegate {
    
    
    var delegate: ICartDelegate?
    
    // MARK: Outlets faisant le lien avec les objets dans la vue
    @IBOutlet weak var nameCustomerTextField: UITextField!
    @IBOutlet weak var firstNameCustomerTextField: UITextField!
    @IBOutlet weak var phoneNumberCustomerTextField: UITextField!
    @IBOutlet weak var buttonValidate: UIButton!
    
    // Gestion du click de validation de la commande
    @IBAction func onClickValidateCommand(_ sender: UIButton) {
        let alert : UIAlertController = UIAlertController(title: "Validation", message: "Commande enregistrée. Merci et bon appetit!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{UIAlertAction in (
            self.delegate!.clearCart(), // on doit vider le panier!
            self.performSegue(withIdentifier: "GoBackHome", sender: self)
            )}))
        self.present(alert, animated: true, completion: nil)
        
    }
   
    // MARK: GESTION DES EVENEMENTS LIES AU CONTROLEUR
    override func viewDidLoad() {
        super.viewDidLoad()
        // on défini le controleur InfoCustomerVC comme délégué en charge de controler les textfields.
        nameCustomerTextField.delegate = self
        firstNameCustomerTextField.delegate = self
        phoneNumberCustomerTextField.delegate = self
        buttonValidate.isEnabled = false // par défaut on peut pas valider car le formulaire n'est pas rempli

    }
    
    // MARK: methodes implémentables car le controleur hérite de UITextFieldDelegate
    // permet de fermer le clavier de saisie lorsque l'on tap en dehors dudit clavier
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            // détecte la sortie du clavier graphique
            self.view.endEditing(true)
        
        // le bouton valider doit être desactivé si l'on a pas remplis le formulaire!
        if nameCustomerTextField.text!.count > 3 && firstNameCustomerTextField.text!.count > 3 && phoneNumberCustomerTextField.text!.count > 8
        {
            buttonValidate.isEnabled = true
        }
        else
        {
             buttonValidate.isEnabled = false
        }
    }

}
