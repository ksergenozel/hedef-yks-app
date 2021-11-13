//
//  Calis1ViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 22.03.2021.
//

import UIKit
import Firebase

class Calis1ViewController: UIViewController {
    
    var timer = Timer()
    var second = "00"
    var minute = "00"
    var hour = "00"
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var saveTimeButton: UIButton!
    @IBOutlet weak var pauseTimeButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var clearTimeButton: UIButton!
    
    var navigasyonBasligi = ""
    
    @IBOutlet weak var bigWatch: UILabel!
    
    var mevcutDers = ""
    var mevcutKonu = ""
    var mevcutSure = ""
    
    var bgTask : UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    
    @IBOutlet weak var mevcutDersLabel: UILabel!
    @IBOutlet weak var mevcutDersDegerLabel: UILabel!
    
    @IBOutlet weak var mevcutKonuLabel: UILabel!
    @IBOutlet weak var mevcutKonuDegerLabel: UILabel!
    
    @IBOutlet weak var mevcutSureLabel: UILabel!
    @IBOutlet weak var mevcutSureDegerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = navigasyonBasligi
        // Do any additional setup after loading the view.
        
        bgTask = UIBackgroundTaskIdentifier(rawValue: 0)
        
        second = "00"
        minute = "00"
        hour = "00"
        
        bigWatch.text = "\(self.hour):\(self.minute):\(self.second)"
        
        stepper.isHidden = true
        saveTimeButton.isHidden = true
        pauseTimeButton.isHidden = true
        startTimeButton.isHidden = false
        clearTimeButton.isHidden = true
        
        mevcutDersLabel.text = "Ders:"
        mevcutKonuLabel.text = "Konu:"
        mevcutSureLabel.text = "Çalışma Süresi:"
        
        mevcutDersDegerLabel.text = mevcutDers
        mevcutKonuDegerLabel.text = mevcutKonu
        mevcutSureDegerLabel.text = mevcutSure
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        if var currentSecond = Int(second) {
            print(currentSecond)
            if var currentMinute = Int(minute) {
                if var currentHour = Int(hour) {
                    switch self.stepper.value {
                    case 5.0:
                        currentMinute += 5
                        self.stepper.value = 0
                    default:
                        currentMinute -= 5
                        self.stepper.value = 0
                    }
                    if currentMinute >= 60 {
                        currentMinute = 0
                        self.minute = "00"
                        currentHour += 1
                        if currentHour < 10 {
                            self.hour = "0\(currentHour)"
                        } else {
                            self.hour = "\(currentHour)"
                        }
                    } else if currentMinute < 0 {
                        if currentHour <= 0 {
                            currentMinute = 0
                            self.minute = "00"
                            currentSecond = 0
                            self.second = "00"
                        } else {
                            currentHour -= 1
                            currentMinute = 55
                            self.minute = "55"
                            if currentHour < 10 {
                                self.hour = "0\(currentHour)"
                            } else {
                                self.hour = "\(currentHour)"
                            }
                        }
                    } else if currentMinute < 10 {
                        self.minute = "0\(currentMinute)"
                    } else {
                        self.minute = "\(currentMinute)"
                    }
                }
            }
        }
        bigWatch.text = "\(self.hour):\(self.minute):\(self.second)"
    }
    
    @IBAction func clearTimeButtonClicked(_ sender: UIButton) {
        self.second = "00"
        self.minute = "00"
        self.hour = "00"
        bigWatch.text = "\(self.hour):\(self.minute):\(self.second)"
    }
    @IBAction func saveTimeButtonClicked(_ sender: UIButton) {
        self.startTimeButton.isHidden = false
        self.startTimeButton.isEnabled = true
        self.pauseTimeButton.isHidden = true
        self.stepper.isHidden = true
        self.saveTimeButton.isHidden = true
        self.clearTimeButton.isHidden = true
        
        saveTimeDataToFireStore()
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
//      self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pauseTimeButtonClicked(_ sender: UIButton) {
        self.saveTimeButton.isHidden = false
        self.stepper.isHidden = false
        self.clearTimeButton.isHidden = false
        self.startTimeButton.isEnabled = true
        self.saveTimeButton.isEnabled = true
        
        self.timer.invalidate()
        
        UIApplication.shared.endBackgroundTask(self.bgTask)
    }
    @IBAction func startTimeButtonClicked(_ sender: UIButton) {
        self.pauseTimeButton.isHidden = false
        self.startTimeButton.isEnabled = false
        self.saveTimeButton.isEnabled = false
        
        self.saveTimeButton.isHidden = true
        self.stepper.isHidden = true
        self.clearTimeButton.isHidden = true

        self.bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.bgTask)
        })
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    
    @objc func timerFunction() {
        if var currentSecond = Int(second) {
            if var currentMinute = Int(minute) {
                if var currentHour = Int(hour) {
                    currentSecond += 1
                    if currentSecond < 10 {
                        self.second = "0\(currentSecond)"
                    } else {
                        self.second = "\(currentSecond)"
                    }
                    if currentSecond == 60 {
                        currentSecond = 0
                        self.second = "00"
                        currentMinute += 1
                        if currentMinute < 10 {
                            self.minute = "0\(currentMinute)"
                        } else {
                            self.minute = "\(currentMinute)"
                        }
                        if currentMinute == 60 {
                            currentMinute = 0
                            self.minute = "00"
                            currentHour += 1
                            if currentHour < 10 {
                                self.hour = "0\(currentHour)"
                            } else {
                                self.hour = "\(currentHour)"
                            }
                        }
                    }
                }
            }
        }
        bigWatch.text = "\(self.hour):\(self.minute):\(self.second)"
    }
    
    func saveTimeDataToFireStore() {
        
        if var currentSecond = Int(second) {
            if var currentMinute = Int(minute) {
                if var currentHour = Int(hour) {
                    let db = Firestore.firestore()
                    if let userUid = Auth.auth().currentUser?.uid {
                        let docRef = db.collection("Users").document(userUid)
                        
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                if let datas = document.get("\(self.mevcutDers) Süre") as? [String:String] {
                                    if let gelenVeri = datas["\(self.mevcutKonu)"] {
                                        let gelenSaatDakikaSaniye = gelenVeri.split(separator: ":")
                                        let gelenSaat = gelenSaatDakikaSaniye[0]
                                        let gelenDakika = gelenSaatDakikaSaniye[1]
                                        let gelenSaniye = gelenSaatDakikaSaniye[2]
                                        print("Gelen Saat = \(gelenSaat)")
                                        print("Gelen Dakika = \(gelenDakika)")
                                        print("Gelen Saniye = \(gelenSaniye)")
                                        
                                        if let intGelenSaat = Int(gelenSaat) {
                                            if let intGelenDakika = Int(gelenDakika) {
                                                if let intGelenSaniye = Int(gelenSaniye) {
                                                    var toplamSaat = intGelenSaat + currentHour
                                                    var toplamDakika = intGelenDakika + currentMinute
                                                    var toplamSaniye = intGelenSaniye + currentSecond
                                                    
                                                    let theCurrentHour = currentHour
                                                    let theCurrentMinute = currentMinute
                                                    let theCurrentSecond = currentSecond
                                                    
                                                    print("BURASI ÖNEMLİ")
                                                    print("currenhour = \(currentHour)")
                                                    print("currentminute = \(currentMinute)")
                                                    print("currentsecond = \(currentSecond)")
                                                    print("BURASI ÖNEMLİ")
                                            
                                                    if toplamSaniye >= 60 {
                                                        toplamSaniye = toplamSaniye - 60
                                                        toplamDakika += 1
                                                    }
                                                    if toplamDakika >= 60 {
                                                        toplamDakika = toplamDakika - 60
                                                        toplamSaat += 1
                                                    }
                                                    
                                                    var strToplamSaniye : String = ""
                                                    var strToplamDakika : String = ""
                                                    var strToplamSaat : String = ""
                                                    
                                                    if toplamSaniye < 10 {
                                                        strToplamSaniye = "0\(toplamSaniye)"
                                                    } else {
                                                        strToplamSaniye = "\(toplamSaniye)"
                                                    }
                                                    if toplamDakika < 10 {
                                                        strToplamDakika = "0\(toplamDakika)"
                                                    } else {
                                                        strToplamDakika = "\(toplamDakika)"
                                                    }
                                                    if toplamSaat < 10 {
                                                        strToplamSaat = "0\(toplamSaat)"
                                                    } else {
                                                        strToplamSaat = "\(toplamSaat)"
                                                    }
                                                    
                                                    let yazilacakVeri = strToplamSaat + ":" + strToplamDakika + ":" + strToplamSaniye
                                                    
                                                    self.mevcutSureDegerLabel.text = yazilacakVeri
                                                    
                                                    db.collection("Users").document(userUid).setData(["\(self.mevcutDers) Süre":["\(self.mevcutKonu)":"\(yazilacakVeri)"]], merge: true)
                                                    
                                                    let tryTytOrAytOrYdt = self.mevcutDers.split(separator: " ")
                                                    let tytOrAytOrYdt = tryTytOrAytOrYdt[0]
                                                    var digerleri = tryTytOrAytOrYdt[1]
                                                    
                                                    if tryTytOrAytOrYdt.count > 2 {
                                                        digerleri = digerleri + " " + tryTytOrAytOrYdt[2]
                                                    }
                                                    
                                                    print(tytOrAytOrYdt)
                                                    
                                                    // içinde bulunduğumuz dersin toplam saatini almak
                                                    let docRef = db.collection("Users").document(userUid)
                                                    
                                                    docRef.getDocument { (document, error) in
                                                        if let document = document, document.exists {
                                                            if let datas = document.get("\(tytOrAytOrYdt) Ders Süre") as? [String:String] {
                                                                if let dersinAnlikToplamSaati = datas["\(digerleri)"] {
                                                                    print("Dersin Anlik Toplam Saati = \(dersinAnlikToplamSaati)")
                                                                    let ayristir = dersinAnlikToplamSaati.split(separator: ":")
                                                                    
                                                                    let dersinToplamSaati = ayristir[0]
                                                                    let dersinToplamDakikasi = ayristir[1]
                                                                    let dersinToplamSaniyesi = ayristir[2]
                                                                    
                                                                    let intDersinToplamSaati = Int(dersinToplamSaati)
                                                                    let intDersinToplamDakikası = Int(dersinToplamDakikasi)
                                                                    let intDersinToplamSaniyesi = Int(dersinToplamSaniyesi)
                                                                                                                
                                                                    var enToplamSaat = intDersinToplamSaati! + theCurrentHour
                                                                    var enToplamDakika = intDersinToplamDakikası! + theCurrentMinute
                                                                    var enToplamSaniye = intDersinToplamSaniyesi! + theCurrentSecond
                                                                    
                                                                    if enToplamSaniye >= 60 {
                                                                        enToplamSaniye = enToplamSaniye - 60
                                                                        enToplamDakika += 1
                                                                    }
                                                                    if enToplamDakika >= 60 {
                                                                        enToplamDakika = enToplamDakika - 60
                                                                        enToplamSaat += 1
                                                                    }
                                                                    
                                                                    var strEnToplamSaniye : String = ""
                                                                    var strEnToplamDakika : String = ""
                                                                    var strEnToplamSaat : String = ""
                                                                    
                                                                    if enToplamSaniye < 10 {
                                                                        strEnToplamSaniye = "0\(enToplamSaniye)"
                                                                    } else {
                                                                        strEnToplamSaniye = "\(enToplamSaniye)"
                                                                    }
                                                                    if enToplamDakika < 10 {
                                                                        strEnToplamDakika = "0\(enToplamDakika)"
                                                                    } else {
                                                                        strEnToplamDakika = "\(enToplamDakika)"
                                                                    }
                                                                    if enToplamSaat < 10 {
                                                                        strEnToplamSaat = "0\(enToplamSaat)"
                                                                    } else {
                                                                        strEnToplamSaat = "\(enToplamSaat)"
                                                                    }
                                                                    
                                                                    let yazilacakVeri2 = strEnToplamSaat + ":" + strEnToplamDakika + ":" + strEnToplamSaniye
                                                                    
                                                                    print("BURASI ÖNEMLİ")
                                                                    print("currenhour = \(theCurrentHour)")
                                                                    print("currentminute = \(theCurrentMinute)")
                                                                    print("currentsecond = \(theCurrentSecond)")
                                                                    print("yazilacakveriii2 = \(yazilacakVeri2)")
                                                                    print("BURASI ÖNEMLİ")
                                                                    
                                                                    db.collection("Users").document(userUid).setData(["\(tytOrAytOrYdt) Ders Süre":["\(digerleri)":"\(yazilacakVeri2)"]], merge: true)
                                                                }
                                                                
                                                            }
                                                        }
                                                    }

                                                    currentHour = 0
                                                    currentSecond = 0
                                                    currentMinute = 0
                                                    
                                                    self.hour = "00"
                                                    self.second = "00"
                                                    self.minute = "00"
                                                    
                                                    self.bigWatch.text = "00:00:00"
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                print("Document does not exist")
                            }
                        }
                    }
                }
            }
        }
    }

}
