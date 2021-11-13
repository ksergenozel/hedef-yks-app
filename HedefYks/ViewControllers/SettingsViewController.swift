//
//  SettingsViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logOutAction(_ sender: Any) {
        logOutAction()
    }
    
    func logOutAction() {
        let alert = UIAlertController(title: "Uyarı", message: "Çıkış yapmak üzeresiniz. Bunu onaylıyor musunuz?", preferredStyle: UIAlertController.Style.alert)
        let yesButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { (UIAlertAction) in
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toViewController", sender: nil)
            } catch {
                print("error")
            }
        }
        let noButton = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(noButton)
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func resetButtonClicked(_ sender: Any) {
        guard let url = URL(string: "https://yokatlas.yok.gov.tr/") else { return }
        UIApplication.shared.open(url)
    }
    
    
}
