//
//  saDenemeShowViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 24.03.2021.
//

import UIKit
import Firebase

class saDenemeShowViewController: UIViewController {

    var saDenemeAdi = ""
    var saMatematikDogruSayisi = ""
    var saMatematikYanlisSayisi = ""
    var saMatematikBosSayisi = ""
    var saFenDogruSayisi = ""
    var saFenYanlisSayisi = ""
    var saFenBosSayisi = ""
    var saMatematikNeti = ""
    var saFenNeti = ""
    var toplamNet = ""

    var gelenId = ""
    
    var tümVeriler = [String:String]()
    
    @IBOutlet weak var matDogruTextField: UITextField!
    
    @IBOutlet weak var matYanlisTextField: UITextField!
    
    @IBOutlet weak var matBosTextField: UITextField!
    
    @IBOutlet weak var fenDogruTextField: UITextField!
    
    @IBOutlet weak var fenYanlisTextField: UITextField!
    
    @IBOutlet weak var fenBosTextField: UITextField!
    
    @IBOutlet weak var matNetTextField: UITextField!
    
    @IBOutlet weak var fenNetTextField: UITextField!
    
    @IBOutlet weak var toplamNetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        denemeVerileriniGetir()

    }
    
    func denemeVerileriniGetir() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Denemeleri") as? [String:[String:String]] {
                        for (i,k) in datas {
                            if i == self.gelenId {
                                self.tümVeriler = k
                            }
                        }
                        self.saDenemeAdi = self.tümVeriler["Deneme Adı"]!
                        self.saMatematikDogruSayisi = self.tümVeriler["Matematik Doğru Sayısı"]!
                        self.saMatematikYanlisSayisi = self.tümVeriler["Matematik Yanlış Sayısı"]!
                        self.saMatematikBosSayisi = self.tümVeriler["Matematik Boş Sayısı"]!
                        self.saFenDogruSayisi = self.tümVeriler["Fen Doğru Sayısı"]!
                        self.saFenYanlisSayisi = self.tümVeriler["Fen Yanlış Sayısı"]!
                        self.saFenBosSayisi = self.tümVeriler["Fen Boş Sayısı"]!
                        self.saMatematikNeti = self.tümVeriler["Matematik Neti"]!
                        self.saFenNeti = self.tümVeriler["Fen Neti"]!
                        self.toplamNet = self.tümVeriler["Toplam Net"]!
                    }

                    self.matDogruTextField.text = self.saMatematikDogruSayisi
                    self.matYanlisTextField.text = self.saMatematikYanlisSayisi
                    self.matBosTextField.text = self.saMatematikBosSayisi
                    
                    self.fenDogruTextField.text = self.saFenDogruSayisi
                    self.fenYanlisTextField.text = self.saFenYanlisSayisi
                    self.fenBosTextField.text = self.saFenBosSayisi
                    
                    self.matNetTextField.text = self.saMatematikNeti
                    self.fenNetTextField.text = self.saFenNeti

                    self.toplamNetTextField.text = self.toplamNet
                    
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}
