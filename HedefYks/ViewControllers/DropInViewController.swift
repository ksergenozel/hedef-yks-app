//
//  DropInViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase

class DropInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        self.emailText.delegate = self
        self.passwordText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.emailText:
            self.passwordText.becomeFirstResponder()
        default:
            self.passwordText.resignFirstResponder()
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
  
    @IBAction func dropInButtonClicked(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
                if error != nil {
                    self.makeAlert(title: "Hata", message: error?.localizedDescription ?? "Bir hata oluştu. Lütfen tekrar deneyin.")
                } else {
                    self.performSegue(withIdentifier: "toTabBarControllerAfterDropIn", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Hata", message: "Lütfen tüm boşlukları doldurun.")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
