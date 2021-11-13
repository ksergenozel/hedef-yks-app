//
//  aytDenemeEkleViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 23.03.2021.
//

import UIKit
import Firebase

class aytDenemeEkleViewController: UIViewController {
    
    var anlikIndex = 0
    
    @IBOutlet weak var segmentedControlStatus: UISegmentedControl!

    @IBOutlet weak var matematikTextField: UILabel!
    
    @IBOutlet weak var edebiyatTextField: UILabel!
    
    @IBOutlet weak var sosyal1TextField: UILabel!
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var textField3: UITextField!
    
    @IBOutlet weak var textField4: UITextField!
    
    @IBOutlet weak var textField5: UITextField!
    
    @IBOutlet weak var textField6: UITextField!
    
    @IBOutlet weak var textField7: UITextField!
    
    @IBOutlet weak var textField8: UITextField!
    
    @IBOutlet weak var textField9: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        matematikTextField.text = "Matematik"
        edebiyatTextField.text = "Edebiyat"
        sosyal1TextField.text = "Sosyal 1"
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            anlikIndex = 0
            sosyal1TextField.isHidden = false
            textField7.isHidden = false
            textField8.isHidden = false
            textField9.isHidden = false
            
            matematikTextField.text = "Matematik"
            edebiyatTextField.text = "Edebiyat"
            sosyal1TextField.text = "Sosyal 1"
            break
        case 1:
            anlikIndex = 1
            
            sosyal1TextField.isHidden = true
            textField7.isHidden = true
            textField8.isHidden = true
            textField9.isHidden = true
            
            matematikTextField.text = "Matematik"
            edebiyatTextField.text = "Fen"
            break
        case 2:
            anlikIndex = 2
            sosyal1TextField.isHidden = false
            textField7.isHidden = false
            textField8.isHidden = false
            textField9.isHidden = false
            
            matematikTextField.text = "Edebiyat"
            edebiyatTextField.text = "Sosyal 1"
            sosyal1TextField.text = "Sosyal 2"
            break
        default:
            break
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        switch self.anlikIndex {
        case 0:
            esitAgirlikDenemeKaydet()
            break
        case 1:
            sayisalDenemeKaydet()
            break
        case 2:
            sozelDenemeKaydet()
            break
        default:
            break
        }
    }
    
    func esitAgirlikDenemeKaydet() {
        if textField1.text != "" && textField2.text != "" && textField3.text != "" {
            if textField4.text != "" && textField5.text != "" && textField6.text != "" {
                if textField7.text != "" && textField8.text != "" && textField9.text != "" {
                    
                    let matematikDogruSayisi = Int(textField1.text!)!
                    let matematikYanlisSayisi = Int(textField2.text!)!
                    let matematikBosSayisi = Int(textField3.text!)!
                    
                    let edebiyatDogruSayisi = Int(textField4.text!)!
                    let edebiyatYanlisSayisi = Int(textField5.text!)!
                    let edebiyatBosSayisi = Int(textField6.text!)!
                    
                    let sosyal1DogruSayisi = Int(textField7.text!)!
                    let sosyal1YanlisSayisi = Int(textField8.text!)!
                    let sosyal1BosSayisi = Int(textField9.text!)!
                    
                    let matematikToplam = matematikDogruSayisi + matematikYanlisSayisi + matematikBosSayisi
                    
                    let edebiyatArtiSosyal1Toplam = edebiyatDogruSayisi + edebiyatYanlisSayisi + edebiyatBosSayisi + sosyal1DogruSayisi + sosyal1YanlisSayisi + sosyal1BosSayisi
                    
                    if matematikToplam == 40 {
                        if edebiyatArtiSosyal1Toplam == 40 {
                            
                            // net hesaplama
                            let matematikNeti = Double(matematikDogruSayisi) - (Double(matematikYanlisSayisi) * 0.25)
                            
                            let edebiyatNeti = Double(edebiyatDogruSayisi) - (Double(edebiyatYanlisSayisi) * 0.25)
                            
                            let sosyal1Neti = Double(sosyal1DogruSayisi) - (Double(sosyal1YanlisSayisi) * 0.25)
                            
                            let toplamNet = matematikNeti + edebiyatNeti + sosyal1Neti
                            
                            // deneme türünü oluşturalım
                            let denemeTuru = "Eşit Ağırlık"
                    
                            // deneme için id
                            let denemeId = UUID().uuidString
                            
                            // deneme adı için
                            let alert = UIAlertController(title: "Deneme Adı Ekle", message: nil, preferredStyle: UIAlertController.Style.alert)
                            alert.addTextField()
                            
                            let cancelAction = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
                            
                            let submitAction = UIAlertAction(title: "Kaydet", style: UIAlertAction.Style.default) { (UIAlertAction) in
                                let denemeAdiTextField = alert.textFields![0]
                                
                                if let denemeAdi = denemeAdiTextField.text {
                                    let denemeVerisi = ["AYT Denemeleri":["\(denemeId)":["Deneme Türü":"\(denemeTuru)","Deneme Adı":"\(denemeAdi)","Matematik Doğru Sayısı":"\(matematikDogruSayisi)","Matematik Yanlış Sayısı":"\(matematikYanlisSayisi)","Matematik Boş Sayısı":"\(matematikBosSayisi)","Edebiyat Doğru Sayısı":"\(edebiyatDogruSayisi)","Edebiyat Yanlış Sayısı":"\(edebiyatYanlisSayisi)","Edebiyat Boş Sayısı":"\(edebiyatBosSayisi)","Sosyal 1 Doğru Sayısı":"\(sosyal1DogruSayisi)","Sosyal 1 Yanlış Sayısı":"\(sosyal1YanlisSayisi)","Sosyal 1 Boş Sayısı":"\(sosyal1BosSayisi)","Matematik Neti":"\(matematikNeti)","Edebiyat Neti":"\(edebiyatNeti)","Sosyal 1 Neti":"\(sosyal1Neti)","Toplam Net":"\(toplamNet)"]]]
                                    
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
                            makeAlert(title: "Hata", message: "Edebiyat - Sosyal 1 testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                        }
                    } else {
                        makeAlert(title: "Hata", message: "Matematik testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                    }
                } else {
                    makeAlert(title: "Hata", message: "Sosyal 1 bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
                }
            } else {
                makeAlert(title: "Hata", message: "Edebiyat bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
            }
        } else {
            makeAlert(title: "Hata", message: "Matematik bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
        }
    }
    
    func sayisalDenemeKaydet() {
        if textField1.text != "" && textField2.text != "" && textField3.text != "" {
            if textField4.text != "" && textField5.text != "" && textField6.text != "" {
                
                    
                    let matematikDogruSayisi = Int(textField1.text!)!
                    let matematikYanlisSayisi = Int(textField2.text!)!
                    let matematikBosSayisi = Int(textField3.text!)!
                    
                    let fenDogruSayisi = Int(textField4.text!)!
                    let fenYanlisSayisi = Int(textField5.text!)!
                    let fenBosSayisi = Int(textField6.text!)!
                    

                    let matematikToplam = matematikDogruSayisi + matematikYanlisSayisi + matematikBosSayisi
                    
                    let fenToplam = fenDogruSayisi + fenYanlisSayisi + fenBosSayisi
                    
                    if matematikToplam == 40 {
                        if fenToplam == 40 {
                            
                            // net hesaplama
                            let matematikNeti = Double(matematikDogruSayisi) - (Double(matematikYanlisSayisi) * 0.25)
                            
                            let fenNeti = Double(fenDogruSayisi) - (Double(fenYanlisSayisi) * 0.25)
                            
                            let toplamNet = matematikNeti + fenNeti
                            
                            // deneme türünü oluşturalım
                            let denemeTuru = "Sayısal"
                    
                            // deneme için id
                            let denemeId = UUID().uuidString
                            
                            // deneme adı için
                            let alert = UIAlertController(title: "Deneme Adı Ekle", message: nil, preferredStyle: UIAlertController.Style.alert)
                            alert.addTextField()
                            
                            let cancelAction = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
                            
                            let submitAction = UIAlertAction(title: "Kaydet", style: UIAlertAction.Style.default) { (UIAlertAction) in
                                let denemeAdiTextField = alert.textFields![0]
                                
                                if let denemeAdi = denemeAdiTextField.text {
                                    let denemeVerisi = ["AYT Denemeleri":["\(denemeId)":["Deneme Türü":"\(denemeTuru)","Deneme Adı":"\(denemeAdi)","Matematik Doğru Sayısı":"\(matematikDogruSayisi)","Matematik Yanlış Sayısı":"\(matematikYanlisSayisi)","Matematik Boş Sayısı":"\(matematikBosSayisi)","Fen Doğru Sayısı":"\(fenDogruSayisi)","Fen Yanlış Sayısı":"\(fenYanlisSayisi)","Fen Boş Sayısı":"\(fenBosSayisi)","Matematik Neti":"\(matematikNeti)","Fen Neti":"\(fenNeti)","Toplam Net":"\(toplamNet)"]]]
                                    
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
                            makeAlert(title: "Hata", message: "Fen testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                        }
                    } else {
                        makeAlert(title: "Hata", message: "Matematik testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                    }
            } else {
                makeAlert(title: "Hata", message: "Fen bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
            }
        } else {
            makeAlert(title: "Hata", message: "Matematik bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
        }
    }
    
    func sozelDenemeKaydet() {
        if textField1.text != "" && textField2.text != "" && textField3.text != "" {
            if textField4.text != "" && textField5.text != "" && textField6.text != "" {
                if textField7.text != "" && textField8.text != "" && textField9.text != "" {
                    
                    let edebiyatDogruSayisi = Int(textField1.text!)!
                    let edebiyatYanlisSayisi = Int(textField2.text!)!
                    let edebiyatBosSayisi = Int(textField3.text!)!
                    
                    let sosyal1DogruSayisi = Int(textField4.text!)!
                    let sosyal1YanlisSayisi = Int(textField5.text!)!
                    let sosyal1BosSayisi = Int(textField6.text!)!
                    
                    let sosyal2DogruSayisi = Int(textField7.text!)!
                    let sosyal2YanlisSayisi = Int(textField8.text!)!
                    let sosyal2BosSayisi = Int(textField9.text!)!
                    
                    let edebiyatArtiSosyal1Toplam = edebiyatDogruSayisi + edebiyatYanlisSayisi + edebiyatBosSayisi + sosyal1DogruSayisi + sosyal1YanlisSayisi + sosyal1BosSayisi
                    
                    let sosyal2Toplam = sosyal2DogruSayisi + sosyal2YanlisSayisi + sosyal2BosSayisi
                    
                    if edebiyatArtiSosyal1Toplam == 40 {
                        if sosyal2Toplam == 40 {
                            
                            // net hesaplama
                            let edebiyatNeti = Double(edebiyatDogruSayisi) - (Double(edebiyatYanlisSayisi) * 0.25)
                            
                            let sosyal1Neti = Double(sosyal1DogruSayisi) - (Double(sosyal1YanlisSayisi) * 0.25)
                            
                            let sosyal2Neti = Double(sosyal2DogruSayisi) - (Double(sosyal2YanlisSayisi) * 0.25)
                            
                            let toplamNet = edebiyatNeti + sosyal1Neti + sosyal2Neti
                            
                            // deneme türünü oluşturalım
                            let denemeTuru = "Sözel"
                    
                            // deneme için id
                            let denemeId = UUID().uuidString
                            
                            // deneme adı için
                            let alert = UIAlertController(title: "Deneme Adı Ekle", message: nil, preferredStyle: UIAlertController.Style.alert)
                            alert.addTextField()
                            
                            let cancelAction = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
                            
                            let submitAction = UIAlertAction(title: "Kaydet", style: UIAlertAction.Style.default) { (UIAlertAction) in
                                let denemeAdiTextField = alert.textFields![0]
                                
                                if let denemeAdi = denemeAdiTextField.text {
                                    let denemeVerisi = ["AYT Denemeleri":["\(denemeId)":["Deneme Türü":"\(denemeTuru)","Deneme Adı":"\(denemeAdi)","Edebiyat Doğru Sayısı":"\(edebiyatDogruSayisi)","Edebiyat Yanlış Sayısı":"\(edebiyatYanlisSayisi)","Edebiyat Boş Sayısı":"\(edebiyatBosSayisi)","Sosyal 1 Doğru Sayısı":"\(sosyal1DogruSayisi)","Sosyal 1 Yanlış Sayısı":"\(sosyal1YanlisSayisi)","Sosyal 1 Boş Sayısı":"\(sosyal1BosSayisi)","Sosyal 2 Doğru Sayısı":"\(sosyal2DogruSayisi)","Sosyal 2 Yanlış Sayısı":"\(sosyal2YanlisSayisi)","Sosyal 2 Boş Sayısı":"\(sosyal2BosSayisi)","Edebiyat Neti":"\(edebiyatNeti)","Sosyal 1 Neti":"\(sosyal1Neti)","Sosyal 2 Neti":"\(sosyal2Neti)","Toplam Net":"\(toplamNet)"]]]
                                    
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
                            makeAlert(title: "Hata", message: "Sosyal 2 testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                        }
                    } else {
                        makeAlert(title: "Hata", message: "Edebiyat - Sosyal 1 testi toplam 40 sorudan oluşmaktadır. Girmiş olduğunuz doğru, yanlış ve boş sayılarının toplamı olması gerekenden eksik ya da fazla.")
                    }
                } else {
                    makeAlert(title: "Hata", message: "Sosyal 2 bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
                }
            } else {
                makeAlert(title: "Hata", message: "Sosyal 1 bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
            }
        } else {
            makeAlert(title: "Hata", message: "Edebiyat bölümündeki doğru, yanlış ve boş sayılarından en az birini yanlış veya eksik girdiniz. Boş bırakmak istediğiniz kısımlara 0 girebilirsiniz.")
        }
    }
    
    
    func makeAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
