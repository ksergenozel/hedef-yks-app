//
//  soDenemeShowViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 24.03.2021.
//

import UIKit
import Firebase

class soDenemeShowViewController: UIViewController {

    var soDenemeAdi = ""
    var soEdebiyatDogruSayisi = ""
    var soEdebiyatYanlisSayisi = ""
    var soEdebiyatBosSayisi = ""
    var soSosyal1DogruSayisi = ""
    var soSosyal1YanlisSayisi = ""
    var soSosyal1BosSayisi = ""
    var soSosyal2DogruSayisi = ""
    var soSosyal2YanlisSayisi = ""
    var soSosyal2BosSayisi = ""
    var soEdebiyatNeti = ""
    var soSosyal1Neti = ""
    var soSosyal2Neti = ""
    var toplamNet = ""
    
    var gelenId = ""
    
    var tümVeriler = [String:String]()
    
    @IBOutlet weak var edebiyatDogruTextField: UITextField!
    
    @IBOutlet weak var edebiyatYanlisTextField: UITextField!
    
    @IBOutlet weak var edebiyatBosTextField: UITextField!
    
    @IBOutlet weak var sosyal1DogruTextField: UITextField!
    
    @IBOutlet weak var sosyal1YanlisTextField: UITextField!
    
    @IBOutlet weak var sosyal1BosTextField: UITextField!
    
    @IBOutlet weak var sosyal2DogruTextField: UITextField!
    
    @IBOutlet weak var sosyal2YanlisTextField: UITextField!
    
    @IBOutlet weak var sosyal2BosTextField: UITextField!
    
    @IBOutlet weak var edebiyatNetTextField: UITextField!
    
    @IBOutlet weak var sosyal1NetTextField: UITextField!
    
    @IBOutlet weak var sosyal2NetTextField: UITextField!
    
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
                        self.soDenemeAdi = self.tümVeriler["Deneme Adı"]!
                        self.soEdebiyatDogruSayisi = self.tümVeriler["Edebiyat Doğru Sayısı"]!
                        self.soEdebiyatYanlisSayisi = self.tümVeriler["Edebiyat Yanlış Sayısı"]!
                        self.soEdebiyatBosSayisi = self.tümVeriler["Edebiyat Boş Sayısı"]!
                        self.soSosyal1DogruSayisi = self.tümVeriler["Sosyal 1 Doğru Sayısı"]!
                        self.soSosyal1YanlisSayisi = self.tümVeriler["Sosyal 1 Yanlış Sayısı"]!
                        self.soSosyal1BosSayisi = self.tümVeriler["Sosyal 1 Boş Sayısı"]!
                        self.soSosyal2DogruSayisi = self.tümVeriler["Sosyal 2 Doğru Sayısı"]!
                        self.soSosyal2YanlisSayisi = self.tümVeriler["Sosyal 2 Yanlış Sayısı"]!
                        self.soSosyal2BosSayisi = self.tümVeriler["Sosyal 2 Boş Sayısı"]!
                        self.soEdebiyatNeti = self.tümVeriler["Edebiyat Neti"]!
                        self.soSosyal1Neti = self.tümVeriler["Sosyal 1 Neti"]!
                        self.soSosyal2Neti = self.tümVeriler["Sosyal 2 Neti"]!
                        self.toplamNet = self.tümVeriler["Toplam Net"]!
                    }
                    
                    self.edebiyatDogruTextField.text = self.soEdebiyatDogruSayisi
                    self.edebiyatYanlisTextField.text = self.soEdebiyatYanlisSayisi
                    self.edebiyatBosTextField.text = self.soEdebiyatBosSayisi
                    
                    self.sosyal1DogruTextField.text = self.soSosyal1DogruSayisi
                    self.sosyal1YanlisTextField.text = self.soSosyal1YanlisSayisi
                    self.sosyal1BosTextField.text = self.soSosyal1BosSayisi
                    
                    self.sosyal2DogruTextField.text = self.soSosyal2DogruSayisi
                    self.sosyal2YanlisTextField.text = self.soSosyal2YanlisSayisi
                    self.sosyal2BosTextField.text = self.soSosyal2BosSayisi
                    
                    self.edebiyatNetTextField.text = self.soEdebiyatNeti
                    self.sosyal1NetTextField.text = self.soSosyal1Neti
                    self.sosyal2NetTextField.text = self.soSosyal2Neti
                    
                    self.toplamNetTextField.text = self.toplamNet
                    
                } else {
                    print("Document does not exist")
                }
            }
        }
    }

}
