//
//  eaDenemeShowViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 24.03.2021.
//

import UIKit
import Firebase

class eaDenemeShowViewController: UIViewController {

    var eaDenemeAdi = ""
    var eaMatematikDogruSayisi = ""
    var eaMatematikYanlisSayisi = ""
    var eaMatematikBosSayisi = ""
    var eaEdebiyatDogruSayisi = ""
    var eaEdebiyatYanlisSayisi = ""
    var eaEdebiyatBosSayisi = ""
    var eaSosyal1DogruSayisi = ""
    var eaSosyal1YanlisSayisi = ""
    var eaSosyal1BosSayisi = ""
    var eaMatematikNeti = ""
    var eaEdebiyatNeti = ""
    var eaSosyal1Neti = ""
    var toplamNet = ""
    
    var gelenId = ""
    
    var tümVeriler = [String:String]()
    
    @IBOutlet weak var matDogruTextField: UITextField!
    
    @IBOutlet weak var matYanlisTextField: UITextField!
    
    @IBOutlet weak var matBosTextField: UITextField!
    
    @IBOutlet weak var edebiyatDogruTextField: UITextField!
    
    @IBOutlet weak var edebiyatYanlisTextField: UITextField!
    
    @IBOutlet weak var edebiyatBosTextField: UITextField!
    
    @IBOutlet weak var sosyal1DogruTextField: UITextField!
    
    @IBOutlet weak var sosyal1YanlisTextField: UITextField!
    
    @IBOutlet weak var sosyal1BosTextField: UITextField!
    
    @IBOutlet weak var matNetTextField: UITextField!
    
    @IBOutlet weak var edebiyatNetTextField: UITextField!
    
    @IBOutlet weak var sosyal1NetTextField: UITextField!
    
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
                        self.eaDenemeAdi = self.tümVeriler["Deneme Adı"]!
                        self.eaMatematikDogruSayisi = self.tümVeriler["Matematik Doğru Sayısı"]!
                        self.eaMatematikYanlisSayisi = self.tümVeriler["Matematik Yanlış Sayısı"]!
                        self.eaMatematikBosSayisi = self.tümVeriler["Matematik Boş Sayısı"]!
                        self.eaEdebiyatDogruSayisi = self.tümVeriler["Edebiyat Doğru Sayısı"]!
                        self.eaEdebiyatYanlisSayisi = self.tümVeriler["Edebiyat Yanlış Sayısı"]!
                        self.eaEdebiyatBosSayisi = self.tümVeriler["Edebiyat Boş Sayısı"]!
                        self.eaSosyal1DogruSayisi = self.tümVeriler["Sosyal 1 Doğru Sayısı"]!
                        self.eaSosyal1YanlisSayisi = self.tümVeriler["Sosyal 1 Yanlış Sayısı"]!
                        self.eaSosyal1BosSayisi = self.tümVeriler["Sosyal 1 Boş Sayısı"]!
                        self.eaMatematikNeti = self.tümVeriler["Matematik Neti"]!
                        self.eaEdebiyatNeti = self.tümVeriler["Edebiyat Neti"]!
                        self.eaSosyal1Neti = self.tümVeriler["Sosyal 1 Neti"]!
                        self.toplamNet = self.tümVeriler["Toplam Net"]!
                    }
                    
                    self.matDogruTextField.text = self.eaMatematikDogruSayisi
                    self.matYanlisTextField.text = self.eaMatematikYanlisSayisi
                    self.matBosTextField.text = self.eaMatematikBosSayisi
                    
                    self.edebiyatDogruTextField.text = self.eaEdebiyatDogruSayisi
                    self.edebiyatYanlisTextField.text = self.eaEdebiyatYanlisSayisi
                    self.edebiyatBosTextField.text = self.eaEdebiyatBosSayisi
                    
                    self.sosyal1DogruTextField.text = self.eaSosyal1DogruSayisi
                    self.sosyal1YanlisTextField.text = self.eaSosyal1YanlisSayisi
                    self.sosyal1BosTextField.text = self.eaSosyal1BosSayisi
                    
                    self.matNetTextField.text = self.eaMatematikNeti
                    self.edebiyatNetTextField.text = self.eaEdebiyatNeti
                    self.sosyal1NetTextField.text = self.eaSosyal1Neti
                    
                    self.toplamNetTextField.text = self.toplamNet
                    
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
}
