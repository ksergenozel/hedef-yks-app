//
//  EnterViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase

class EnterViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterButtonClicked(_ sender: UIButton) {
        if firstTextField.text != "" && secondTextField.text != "" {
            Auth.auth().signIn(withEmail: firstTextField.text!, password: secondTextField.text!) { (auth, error) in
                if error != nil {
                    self.makeAlert(title: "Hata", message: error?.localizedDescription ?? "Bir hata oluştu. Lütfen tekrar deneyin.")
                } else {
                    self.performSegue(withIdentifier: "toTabBarControllerAfterEnter", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Hata", message: "Lütfen tüm alanları doldurun.")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
