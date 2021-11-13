//
//  tytDenemeEkleViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 23.03.2021.
//

import UIKit
import Firebase

class tytDenemeEkleViewController: UIViewController {

    @IBOutlet weak var turkceDogruTextField: UITextField!
    @IBOutlet weak var turkceYanlisTextField: UITextField!
    @IBOutlet weak var turkceBosTextField: UITextField!
    
    @IBOutlet weak var sosyalDogruTextField: UITextField!
    @IBOutlet weak var sosyalYanlisTextField: UITextField!
    @IBOutlet weak var sosyalBosTextField: UITextField!
    
    @IBOutlet weak var matematikDogruTextField: UITextField!
    @IBOutlet weak var matematikYanlisTextField: UITextField!
    @IBOutlet weak var matematikBosTextField: UITextField!
    
    @IBOutlet weak var fenDogruTextField: UITextField!
    @IBOutlet weak var fenYanlisTextField: UITextField!
    @IBOutlet weak var fenBosTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @IBAction func denemeyiKaydet(_ sender: UIButton) {
        if turkceDogruTextField.text != "" && turkceYanlisTextField.text != "" && turkceBosTextField.text != "" {
            if sosyalDogruTextField.text != "" && sosyalYanlisTextField.text != "" && sosyalBosTextField.text != "" {
                if matematikDogruTextField.text != "" && matematikYanlisTextField.text != "" && matematikBosTextField.text != "" {
                    if fenDogruTextField.text != "" && fenYanlisTextField.text != "" && fenBosTextField.text != "" {
                        let turkceDogruSayisi = Int(turkceDogruTextField.text!)!
                        let turkceYanlisSayisi = Int(turkceYanlisTextField.text!)!
                        let turkceBosSayisi = Int(turkceBosTextField.text!)!
                        
                        let sosyalDogruSayisi = Int(sosyalDogruTextField.text!)!
                        let sosyalYanlisSayisi = Int(sosyalYanlisTextField.text!)!
                        let sosyalBosSayisi = Int(sosyalBosTextField.text!)!
                        
                        let matematikDogruSayisi = Int(matematikDogruTextField.text!)!
                        let matematikYanlisSayisi = Int(matematikYanlisTextField.text!)!
                        let matematikBosSayisi = Int(matematikBosTextField.text!)!
                        
                        let fenDogruSayisi = Int(fenDogruTextField.text!)!
                        let fenYanlisSayisi = Int(fenYanlisTextField.text!)!
                        let fenBosSayisi = Int(fenBosTextField.text!)!
                        
                        let turkceToplam = turkceDogruSayisi + turkceYanlisSayisi + turkceBosSayisi
                        let sosyalToplam = sosyalDogruSayisi + sosyalYanlisSayisi + sosyalBosSayisi
                        let matematikToplam = matematikDogruSayisi + matematikYanlisSayisi + matematikBosSayisi
                        let fenToplam = fenDogruSayisi + fenYanlisSayisi + fenBosSayisi
                        
                        if turkceToplam == 40 {
                            if sosyalToplam == 20 {
                                if matematikToplam == 40 {
                                    if fenToplam == 20 {
                                        
                                        // net hesabı yapalım
                                        let turkceNeti = Double(turkceDogruSayisi) - (Double(turkceYanlisSayisi) * 0.25)
                                        let sosyalNeti = Double(sosyalDogruSayisi) - (Double(sosyalYanlisSayisi) * 0.25)
                                        let matematikNeti = Double(matematikDogruSayisi) - (Double(matematikYanlisSayisi) * 0.25)
                                        let fenNeti = Double(fenDogruSayisi) - (Double(fenYanlisSayisi) * 0.25)
                                        
                                        let toplamNet = turkceNeti + sosyalNeti + matematikNeti + fenNeti
                                        
                                        // deneme türünü de oluşturalım
                                        let denemeTuru = "TYT"
                                        
                                        // denemenin uid numarası
                                        let denemeId = UUID().uuidString
                                        
                                        // herhangi bir isim koyalım sonra bunu kullanıcıdan alacağız
                                        let alert = UIAlertController(title: "Deneme Adı Ekle", message: nil, preferredStyle: UIAlertController.Style.alert)
                                        alert.addTextField()
                                        
                                        let cancelAction = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
                                        
                                        let submitAction = UIAlertAction(title: "Kaydet", style: UIAlertAction.Style.default) { (UIAlertAction) in
                                            let denemeAdiTextField = alert.textFields![0]
                                            
                                            if let denemeAdi = denemeAdiTextField.text {
                                                let denemeVerisi = ["TYT Denemeleri":["\(denemeId)":["Deneme Türü":"\(denemeTuru)","Deneme Adı":"\(denemeAdi)","Türkçe Doğru Sayısı":"\(turkceDogruSayisi)","Türkçe Yanlış Sayısı":"\(turkceYanlisSayisi)","Türkçe Boş Sayısı":"\(turkceBosSayisi)","Sosyal Doğru Sayısı":"\(sosyalDogruSayisi)","Sosyal Yanlış Sayısı":"\(sosyalYanlisSayisi)","Sosyal Boş Sayısı":"\(sosyalBosSayisi)","Matematik Doğru Sayısı":"\(matematikDogruSayisi)","Matematik Yanlış Sayısı":"\(matematikYanlisSayisi)","Matematik Boş Sayısı":"\(matematikBosSayisi)","Fen Doğru Sayısı":"\(fenDogruSayisi)","Fen Yanlış Sayısı":"\(fenYanlisSayisi)","Fen Boş Sayısı":"\(fenBosSayisi)","Türkçe Neti":"\(turkceNeti)","Sosyal Neti":"\(sosyalNeti)","Matematik Neti":"\(matematikNeti)","Fen Neti":"\(fenNeti)","Toplam Net":"\(toplamNet)"]]]
                                                
                                                print(denemeVerisi)
                                                print(denemeAdi)
                                                
                                                let db = Firestore.firestore()
                                                if let userUid = Auth.auth().currentUser?.uid {
                                                    
                                                    db.collection("Users").document(userUid).setData(denemeVerisi, merge: true)
                                                    
                                                }
                                                
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                        }
                                        
                                        alert.addAction(cancelAction)
                                        alert.addAction(submitAction)
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        
                                    } else {
                                        makeAlert(title: "Hata", message: "Fen testi toplam 20 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                                    }
                                } else {
                                    makeAlert(title: "Hata", message: "Matematik testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                                }
                            } else {
                                makeAlert(title: "Hata", message: "Sosyal testi toplam 20 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                            }
                        } else {
                            makeAlert(title: "Hata", message: "Türkçe testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                        }
                    } else {
                        makeAlert(title: "Hata", message: "Fen bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
                    }
                } else {
                    makeAlert(title: "Hata", message: "Matematik bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
                }
            } else {
                makeAlert(title: "Hata", message: "Sosyal bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
            }
        } else {
            makeAlert(title: "Hata", message: "Türkçe bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
        }
    }
    
    func makeAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
