//
//  Calis2ViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 23.03.2021.
//

import UIKit
import Firebase

class Calis2ViewController: UIViewController {

    var navigasyonBasligi = ""
    var mevcutDers = ""
    var mevcutKonu = ""
    var mevcutSoru = ""
    
    @IBOutlet weak var stepperStatusLabel: UIStepper!
   
    @IBOutlet weak var mevcutDersTitle: UILabel!
    @IBOutlet weak var mevcutKonuTitle: UILabel!
    @IBOutlet weak var mevcutSoruTitle: UILabel!
    
    @IBOutlet weak var mevcutDersValue: UILabel!
    @IBOutlet weak var mevcutKonuValue: UILabel!
    @IBOutlet weak var mevcutSoruValue: UILabel!
    
    @IBOutlet weak var eklenecekSoruLabel: UILabel!
    
    var eskiSoruSayisi : Int = 0
    var eklenecekSoruSayisi : Int = 0
    
    var toplamSoruSayisi : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mevcutDersTitle.text = "Ders:"
        mevcutKonuTitle.text = "Konu:"
        mevcutSoruTitle.text = "Çözülen Soru:"
        
        mevcutDersValue.text = self.mevcutDers
        mevcutKonuValue.text = self.mevcutKonu
        mevcutSoruValue.text = self.mevcutSoru
        
        eskiSoruSayisi = Int(self.mevcutSoru)!
        eklenecekSoruSayisi = 0
        eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
    }
    
    @IBAction func onEkleButtonClicked(_ sender: UIButton) {
        eklenecekSoruSayisi += 10
        eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
    }
    
    @IBAction func onEksiltButtonClicked(_ sender: UIButton) {
        eklenecekSoruSayisi -= 10
        if eklenecekSoruSayisi <= 0 {
            eklenecekSoruSayisi = 0
        }
        eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        eklenecekSoruSayisi = 0
        eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        toplamSoruSayisi = eklenecekSoruSayisi + eskiSoruSayisi
        let yazilacakVeri = String(toplamSoruSayisi)
        // buradasın
        
        print("navigasyonBasligi = \(navigasyonBasligi)")
        print("mevcutDers = \(mevcutDers)")
        print("mevcutKonu = \(mevcutKonu)")
        print("mevcutSoru = \(mevcutSoru)")
    
        self.mevcutSoruValue.text = String(toplamSoruSayisi)
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            
            let mevcutDersParca = self.mevcutDers.split(separator: " ")
            let tytOrAytOrYdt = mevcutDersParca[0]
            var digerleri = mevcutDersParca[1]
            
            if mevcutDersParca.count > 2 {
                digerleri = digerleri + " " + mevcutDersParca[2]
            }
            
            print(tytOrAytOrYdt)
            print(digerleri)
            
            db.collection("Users").document(userUid).setData(["\(self.mevcutDers) Soru":["\(self.mevcutKonu)":"\(yazilacakVeri)"]], merge: true)
            
            db.collection("Users").document(userUid).setData(["\(tytOrAytOrYdt) Ders Soru":["\(digerleri)":"\(yazilacakVeri)"]], merge: true)
        }
        
        eklenecekSoruSayisi = 0
        eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
        
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        switch self.stepperStatusLabel.value {
        case 1.0:
            eklenecekSoruSayisi += 1
            eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
            self.stepperStatusLabel.value = 0
        default:
            eklenecekSoruSayisi -= 1
            if eklenecekSoruSayisi <= 0 {
                eklenecekSoruSayisi = 0
            }
            eklenecekSoruLabel.text = String(eklenecekSoruSayisi)
            self.stepperStatusLabel.value = 0
        }
    }
    
    
    
}
