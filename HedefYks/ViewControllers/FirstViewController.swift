//
//  FirstViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainArray = ["Toplam Konu Çalışma Süresi","Çözülen Toplam Soru Sayısı","Uygulanan Toplam Deneme Sayısı","En Çok Konu Çalışılmış Ders","En Az Konu Çalışılmış Ders","Ders Başı Ortalama Konu Çalışma Süresi","En Çok Çalışılmış Konu","En Az Çalışılmış Konu","Konu Başı Ortalama Konu Çalışma Süresi","En Çok Soru Çözülmüş Ders","En Az Soru Çözülmüş Ders","Ders Başı Ortalama Çözülmüş Soru Sayısı","En Çok Soru Çözülmüş Konu","En Az Soru Çözülmüş Konu","Konu Başı Ortalama Çözülmüş Soru Sayısı","Denemelerdeki En Yüksek Net","Denemelerdeki En Düşük Net","Denemelerdeki Ortalama Net"]
    
    var detailArray = ["00:00:00","0","0","Yeterli veri yok","Yeterli veri yok","00:00:00","Yeterli veri yok","Yeterli veri yok","00:00:00","Yeterli veri yok","Yeterli veri yok","0","Yeterli veri yok","Yeterli veri yok","0","Yeterli veri yok","Yeterli veri yok","Yeterli veri yok"]
    
    var detailArray2 = ["00:00:00","0","0","Yeterli veri yok","Yeterli veri yok","00:00:00","Yeterli veri yok","Yeterli veri yok","00:00:00","Yeterli veri yok","Yeterli veri yok","0","Yeterli veri yok","Yeterli veri yok","0","Yeterli veri yok","Yeterli veri yok","Yeterli veri yok"]
    
    var anlikIndex : Int = 0
    
    @IBOutlet weak var segmentedControlStatus: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        
        anlikIndex = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if anlikIndex == 0 {
            tytToplamKonuCalismaSuresiHesapla()
            tytToplamCozulenSoruSayisiHesapla()
            tytUygulananToplamDenemeSayisiHesapla()
            tytEnCokAzKonuCalisilmisDersHesapla()
            tytEnCokAzCalisilmisKonuHesapla()
            tytEnCokAzSoruCozulmusDers()
            tytEnCokAzSoruCozulmusKonuHesapla()
            tytDenemeleriVerileriniHesapla()
        } else {
            aytToplamKonuCalismaSuresiHesapla()
            aytToplamCozulenSoruSayisiHesapla()
            aytUygulananToplamDenemeSayisiHesapla()
            aytEnCokAzKonuCalisilmisDersHesapla()
            aytEnCokAzCalisilmisKonuHesapla()
            aytEnCokAzSoruCozulmusDers()
            aytEnCokAzSoruCozulmusKonuHesapla()
            aytDenemeleriVerileriniHesapla()
        }
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            anlikIndex = 0
            tytToplamKonuCalismaSuresiHesapla()
            tytToplamCozulenSoruSayisiHesapla()
            tytUygulananToplamDenemeSayisiHesapla()
            tytEnCokAzKonuCalisilmisDersHesapla()
            tytEnCokAzCalisilmisKonuHesapla()
            tytEnCokAzSoruCozulmusDers()
            tytEnCokAzSoruCozulmusKonuHesapla()
            tytDenemeleriVerileriniHesapla()
            break
        case 1:
            anlikIndex = 1
            aytToplamKonuCalismaSuresiHesapla()
            aytToplamCozulenSoruSayisiHesapla()
            aytUygulananToplamDenemeSayisiHesapla()
            aytEnCokAzKonuCalisilmisDersHesapla()
            aytEnCokAzCalisilmisKonuHesapla()
            aytEnCokAzSoruCozulmusDers()
            aytEnCokAzSoruCozulmusKonuHesapla()
            aytDenemeleriVerileriniHesapla()
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "genel")
        cell.textLabel?.text = mainArray[indexPath.row]
        if anlikIndex == 0 {
            cell.detailTextLabel?.text = detailArray[indexPath.row]
        } else if anlikIndex == 1 {
            cell.detailTextLabel?.text = detailArray2[indexPath.row]
        }
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.detailTextLabel?.font = .systemFont(ofSize: CGFloat(15))
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tytToplamKonuCalismaSuresiHesapla() {
        
        // 00:00:00 , 00:00:00
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Ders Süre") as? [String:String] {
                        var toplam = [String]()
                        for (_,k) in datas {
                            toplam.append(k)
                        }
                    
                        var saatArray = [Int]()
                        var dakikaArray = [Int]()
                        var saniyeArray = [Int]()
                        
                        for i in toplam {
                            let array = i.split(separator: ":")
                            saatArray.append(Int(array[0])!)
                            dakikaArray.append(Int(array[1])!)
                            saniyeArray.append(Int(array[2])!)
                        }
                        
                        var saatToplam = 0
                        var dakikaToplam = 0
                        var saniyeToplam = 0
                        
                        for i in saniyeArray {
                            saniyeToplam += i
                        }
                        
                        for i in dakikaArray {
                            dakikaToplam += i
                        }
                        
                        for i in saatArray {
                            saatToplam += i
                        }
                        
                        var gosterilecekSaat = 0
                        var gosterilecekDakika = 0
                        var gosterilecekSaniye = 0
                        
                        if saniyeToplam >= 60 {
                            let tam = saniyeToplam / 60
                            let kalan = saniyeToplam - (60 * tam)
                            
                            gosterilecekSaniye = kalan
                            dakikaToplam += tam
                        } else {
                            gosterilecekSaniye = saniyeToplam
                        }
                        
                        if dakikaToplam >= 60 {
                            let tam = dakikaToplam / 60
                            let kalan = dakikaToplam - (60 * tam)
                            
                            gosterilecekDakika = kalan
                            saatToplam += tam
                        } else {
                            gosterilecekDakika = dakikaToplam
                        }
                        
                        gosterilecekSaat = saatToplam
                        
                        var strSaat = ""
                        var strDakika = ""
                        var strSaniye = ""
                        
                        if gosterilecekSaat < 10 {
                            strSaat = "0\(gosterilecekSaat)"
                        } else {
                            strSaat = "\(gosterilecekSaat)"
                        }
                        
                        if gosterilecekDakika < 10 {
                            strDakika = "0\(gosterilecekDakika)"
                        } else {
                            strDakika = "\(gosterilecekDakika)"
                        }
                        
                        if gosterilecekSaniye < 10 {
                            strSaniye = "0\(gosterilecekSaniye)"
                        } else {
                            strSaniye = "\(gosterilecekSaniye)"
                        }
                        
                        // başka bölüm için
                        let ortalamaSaniye = (gosterilecekSaat * 3600 + gosterilecekDakika * 60 + gosterilecekSaniye) / 10
                        
                        var lazimOrtalamaSaat = 0
                        var lazimOrtalamaDakika = 0
                        var lazimOrtalamaSaniye = ortalamaSaniye
                        
                        if lazimOrtalamaSaniye >= 60 {
                            let tam = lazimOrtalamaSaniye / 60
                            let kalan = lazimOrtalamaSaniye - (60 * tam)
                            
                            lazimOrtalamaSaniye = kalan
                            lazimOrtalamaDakika = tam
                        }
                        
                        if lazimOrtalamaDakika >= 60 {
                            let tam = lazimOrtalamaDakika / 60
                            let kalan = lazimOrtalamaDakika - (60 * tam)
                            
                            lazimOrtalamaDakika = kalan
                            lazimOrtalamaSaat = tam
                        }
                        
                        var strLazimSaniye = ""
                        var strLazimDakika = ""
                        var strLazimSaat = ""
                        
                        if lazimOrtalamaSaat < 10 {
                            strLazimSaat = "0\(lazimOrtalamaSaat)"
                        } else {
                            strLazimSaat = "\(lazimOrtalamaSaat)"
                        }
                        
                        if lazimOrtalamaDakika < 10 {
                            strLazimDakika = "0\(lazimOrtalamaDakika)"
                        } else {
                            strLazimDakika = "\(lazimOrtalamaDakika)"
                        }
                        
                        if lazimOrtalamaSaniye < 10 {
                            strLazimSaniye = "0\(lazimOrtalamaSaniye)"
                        } else {
                            strLazimSaniye = "\(lazimOrtalamaSaniye)"
                        }
                        
                        let lazimGosterilecekVeri = "\(strLazimSaat):\(strLazimDakika):\(strLazimSaniye)"
                        
                        self.detailArray[5] = lazimGosterilecekVeri
                        
                        // buraya kadar başka bölüm için
 
                        let gosterilecekVeri = "\(strSaat):\(strDakika):\(strSaniye)"
                        
                        self.detailArray[0] = gosterilecekVeri
                        
                        self.tableView.reloadData()
                        
                        print("işlem tamam")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func aytToplamKonuCalismaSuresiHesapla() {
        
        // 00:00:00 , 00:00:00
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Ders Süre") as? [String:String] {
                        var toplam = [String]()
                        for (_,k) in datas {
                            toplam.append(k)
                        }
                    
                        var saatArray = [Int]()
                        var dakikaArray = [Int]()
                        var saniyeArray = [Int]()
                        
                        for i in toplam {
                            let array = i.split(separator: ":")
                            saatArray.append(Int(array[0])!)
                            dakikaArray.append(Int(array[1])!)
                            saniyeArray.append(Int(array[2])!)
                        }
                        
                        var saatToplam = 0
                        var dakikaToplam = 0
                        var saniyeToplam = 0
                        
                        for i in saniyeArray {
                            saniyeToplam += i
                        }
                        
                        for i in dakikaArray {
                            dakikaToplam += i
                        }
                        
                        for i in saatArray {
                            saatToplam += i
                        }
                        
                        var gosterilecekSaat = 0
                        var gosterilecekDakika = 0
                        var gosterilecekSaniye = 0
                        
                        if saniyeToplam >= 60 {
                            let tam = saniyeToplam / 60
                            let kalan = saniyeToplam - (60 * tam)
                            
                            gosterilecekSaniye = kalan
                            dakikaToplam += tam
                        } else {
                            gosterilecekSaniye = saniyeToplam
                        }
                        
                        if dakikaToplam >= 60 {
                            let tam = dakikaToplam / 60
                            let kalan = dakikaToplam - (60 * tam)
                            
                            gosterilecekDakika = kalan
                            saatToplam += tam
                        } else {
                            gosterilecekDakika = dakikaToplam
                        }
                        
                        gosterilecekSaat = saatToplam
                        
                        var strSaat = ""
                        var strDakika = ""
                        var strSaniye = ""
                        
                        if gosterilecekSaat < 10 {
                            strSaat = "0\(gosterilecekSaat)"
                        } else {
                            strSaat = "\(gosterilecekSaat)"
                        }
                        
                        if gosterilecekDakika < 10 {
                            strDakika = "0\(gosterilecekDakika)"
                        } else {
                            strDakika = "\(gosterilecekDakika)"
                        }
                        
                        if gosterilecekSaniye < 10 {
                            strSaniye = "0\(gosterilecekSaniye)"
                        } else {
                            strSaniye = "\(gosterilecekSaniye)"
                        }
                        
                        // başka bölüm için
                        let ortalamaSaniye = (gosterilecekSaat * 3600 + gosterilecekDakika * 60 + gosterilecekSaniye) / 10
                        
                        var lazimOrtalamaSaat = 0
                        var lazimOrtalamaDakika = 0
                        var lazimOrtalamaSaniye = ortalamaSaniye
                        
                        if lazimOrtalamaSaniye >= 60 {
                            let tam = lazimOrtalamaSaniye / 60
                            let kalan = lazimOrtalamaSaniye - (60 * tam)
                            
                            lazimOrtalamaSaniye = kalan
                            lazimOrtalamaDakika = tam
                        }
                        
                        if lazimOrtalamaDakika >= 60 {
                            let tam = lazimOrtalamaDakika / 60
                            let kalan = lazimOrtalamaDakika - (60 * tam)
                            
                            lazimOrtalamaDakika = kalan
                            lazimOrtalamaSaat = tam
                        }
                        
                        var strLazimSaniye = ""
                        var strLazimDakika = ""
                        var strLazimSaat = ""
                        
                        if lazimOrtalamaSaat < 10 {
                            strLazimSaat = "0\(lazimOrtalamaSaat)"
                        } else {
                            strLazimSaat = "\(lazimOrtalamaSaat)"
                        }
                        
                        if lazimOrtalamaDakika < 10 {
                            strLazimDakika = "0\(lazimOrtalamaDakika)"
                        } else {
                            strLazimDakika = "\(lazimOrtalamaDakika)"
                        }
                        
                        if lazimOrtalamaSaniye < 10 {
                            strLazimSaniye = "0\(lazimOrtalamaSaniye)"
                        } else {
                            strLazimSaniye = "\(lazimOrtalamaSaniye)"
                        }
                        
                        let lazimGosterilecekVeri = "\(strLazimSaat):\(strLazimDakika):\(strLazimSaniye)"
                        
                        self.detailArray2[5] = lazimGosterilecekVeri
                        
                        // buraya kadar başka bölüm için
                        
                        let gosterilecekVeri = "\(strSaat):\(strDakika):\(strSaniye)"
                        
                        self.detailArray2[0] = gosterilecekVeri
                        
                        self.tableView.reloadData()
                        
                        print("işlem tamam")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }

    func tytToplamCozulenSoruSayisiHesapla() {
            let db = Firestore.firestore()
            if let userUid = Auth.auth().currentUser?.uid {
                let docRef = db.collection("Users").document(userUid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let datas = document.get("TYT Ders Soru") as? [String:String] {
                            var toplam : Int = 0
                            for (_,k) in datas {
                                toplam += Int(k)!
                            }
                            
                            self.detailArray[1] = "\(toplam)"
                            
                            self.tableView.reloadData()
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            }
    }
    
    func aytToplamCozulenSoruSayisiHesapla() {
            let db = Firestore.firestore()
            if let userUid = Auth.auth().currentUser?.uid {
                let docRef = db.collection("Users").document(userUid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let datas = document.get("AYT Ders Soru") as? [String:String] {
                            var toplam : Int = 0
                            for (_,k) in datas {
                                toplam += Int(k)!
                            }
                            
                            self.detailArray2[1] = "\(toplam)"
                            
                            self.tableView.reloadData()
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            }
    }
    
    func tytUygulananToplamDenemeSayisiHesapla() {

        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
      
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Denemeleri") as? [String:[String:String]] {
                        
                        var toplam : Int = 0
                        
                        for _ in datas {
                            toplam += 1
                        }
                        
                        self.detailArray[2] = "\(toplam)"
                        
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }

    }
    
    func aytUygulananToplamDenemeSayisiHesapla() {

        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
      
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Denemeleri") as? [String:[String:String]] {
                        
                        var toplam : Int = 0
                        
                        for _ in datas {
                            toplam += 1
                        }
                        
                        self.detailArray2[2] = "\(toplam)"
                        
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }

    }
    
    func tytEnCokAzKonuCalisilmisDersHesapla() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Ders Süre") as? [String:String] {
                        
                        var derslerArray = [String]()
                        var surelerArray = [String]()
                        
                        for (i,k) in datas {
                            derslerArray.append(i)
                            surelerArray.append(k)
                        }
                        
                        var saniyeArray = [Int]()
                        
                        // 00:00:00
                        
                        for i in surelerArray {
                            let array = i.split(separator: ":")
                            
                            let saat = Int(array[0])!
                            let dakika = Int(array[1])!
                            let saniye = Int(array[2])!
                            
                            var toplamSaniye = saniye
                            toplamSaniye += dakika * 60
                            toplamSaniye += saat * 3600
                            
                            saniyeArray.append(toplamSaniye)
                        }
                        
                        var enBuyukSaniye = saniyeArray[0]
                        var enKucukSaniye = saniyeArray[0]
                        
                        for i in saniyeArray {
                            if i > enBuyukSaniye {
                                enBuyukSaniye = i
                            }
                            if i < enKucukSaniye {
                                enKucukSaniye = i
                            }
                        }
                        
                        let buyukOlanIndex = saniyeArray.firstIndex(of: enBuyukSaniye)
                        let kucukOlanIndex = saniyeArray.firstIndex(of: enKucukSaniye)
                        
                        self.detailArray[3] = derslerArray[buyukOlanIndex!]
                        self.detailArray[4] = derslerArray[kucukOlanIndex!]
                        
                        self.tableView.reloadData()
                        
                        print("işlem tamam")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func aytEnCokAzKonuCalisilmisDersHesapla() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Ders Süre") as? [String:String] {
                        
                        var derslerArray = [String]()
                        var surelerArray = [String]()
                        
                        for (i,k) in datas {
                            derslerArray.append(i)
                            surelerArray.append(k)
                        }
                        
                        var saniyeArray = [Int]()
                        
                        // 00:00:00
                        
                        for i in surelerArray {
                            let array = i.split(separator: ":")
                            
                            let saat = Int(array[0])!
                            let dakika = Int(array[1])!
                            let saniye = Int(array[2])!
                            
                            var toplamSaniye = saniye
                            toplamSaniye += dakika * 60
                            toplamSaniye += saat * 3600
                            
                            saniyeArray.append(toplamSaniye)
                        }
                        
                        var enBuyukSaniye = saniyeArray[0]
                        var enKucukSaniye = saniyeArray[0]
                        
                        for i in saniyeArray {
                            if i > enBuyukSaniye {
                                enBuyukSaniye = i
                            }
                            if i < enKucukSaniye {
                                enKucukSaniye = i
                            }
                        }
                        
                        let buyukOlanIndex = saniyeArray.firstIndex(of: enBuyukSaniye)
                        let kucukOlanIndex = saniyeArray.firstIndex(of: enKucukSaniye)
                        
                        self.detailArray2[3] = derslerArray[buyukOlanIndex!]
                        self.detailArray2[4] = derslerArray[kucukOlanIndex!]
                        
                        self.tableView.reloadData()
                        
                        print("işlem tamam")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func tytEnCokAzCalisilmisKonuHesapla() {
        var derslerArray = [String]()
        var konular = [String]()
        var sureler = [String]()

        var saatler = [Int]()
        var dakikalar = [Int]()
        var saniyeler = [Int]()

        var intSaniyeToplam = [Int]()

        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Ders Süre") as? [String:String] {

                        for (i,_) in datas {
                            derslerArray.append(i)
                        }

                        self.tableView.reloadData()
                    }

                    for i in derslerArray {
                        if let datas = document.get("TYT \(i) Süre") as? [String:String] {

                            for (i,k) in datas {
                                konular.append(i)
                                sureler.append(k)
                            }

                            self.tableView.reloadData()
                        }
                    }

                    

                    for i in sureler {
                        let veriler = i.split(separator: ":")
                        let saat = Int(veriler[0])!
                        let dakika = Int(veriler[1])!
                        let saniye = Int(veriler[2])!

                        saatler.append(saat)
                        dakikalar.append(dakika)
                        saniyeler.append(saniye)
                    }

                    

                    var tur = 0

                    while tur < konular.count {
                        let toplamSaniye = saatler[tur] * 3600 + dakikalar[tur] * 60 + saniyeler[tur] * 1

                        intSaniyeToplam.append(toplamSaniye)

                        tur += 1
                    }

                    // ortalama hesaplama
                    var ortalamaToplam = 0

                    for i in intSaniyeToplam {
                        ortalamaToplam += i
                    }

                    let ortalama = ortalamaToplam / konular.count

                    var ortalamaSaniye = ortalama
                    var ortalamaDakika = 0
                    var ortalamaSaat = 0

                    if ortalamaSaniye >= 60 {
                        let tam = ortalamaSaniye / 60
                        let kalan = ortalamaSaniye - (60 * tam)

                        ortalamaSaniye = kalan
                        ortalamaDakika = tam
                    }

                    if ortalamaDakika >= 60 {
                        let tam = ortalamaDakika / 60
                        let kalan = ortalamaDakika - (60 * tam)

                        ortalamaDakika = kalan
                        ortalamaSaat = tam
                    }

                    var strLazimSaniye = ""
                    var strLazimDakika = ""
                    var strLazimSaat = ""

                    if ortalamaSaat < 10 {
                        strLazimSaat = "0\(ortalamaSaat)"
                    } else {
                        strLazimSaat = "\(ortalamaSaat)"
                    }

                    if ortalamaDakika < 10 {
                        strLazimDakika = "0\(ortalamaDakika)"
                    } else {
                        strLazimDakika = "\(ortalamaDakika)"
                    }

                    if ortalamaSaniye < 10 {
                        strLazimSaniye = "0\(ortalamaSaniye)"
                    } else {
                        strLazimSaniye = "\(ortalamaSaniye)"
                    }

                    let lazimGosterilecekVeri = "\(strLazimSaat):\(strLazimDakika):\(strLazimSaniye)"

                    // ortlaama heasplama bitiş

                    var enBuyukSaniye = intSaniyeToplam[0]
                    var enKucukSaniye = intSaniyeToplam[0]

                    for i in intSaniyeToplam {
                        if i > enBuyukSaniye {
                            enBuyukSaniye = i
                        }
                        if i < enKucukSaniye {
                            enKucukSaniye = i
                        }
                    }

                    let enBuyukIndex = Int(intSaniyeToplam.firstIndex(of: enBuyukSaniye)!)
                    let enKucukIndex = Int(intSaniyeToplam.firstIndex(of: enKucukSaniye)!)

                    let enCokCalisilmisDers = konular[enBuyukIndex]
                    let enAzCalisilmisDers = konular[enKucukIndex]

                    self.detailArray[6] = enCokCalisilmisDers
                    self.detailArray[7] = enAzCalisilmisDers
                    self.detailArray[8] = lazimGosterilecekVeri

                    self.tableView.reloadData()

                    print(intSaniyeToplam)

                } else {
                    print("Document does not exist")
                }
            }
        }
    }

    func aytEnCokAzCalisilmisKonuHesapla() {
        var derslerArray = [String]()
        var konular = [String]()
        var sureler = [String]()

        var saatler = [Int]()
        var dakikalar = [Int]()
        var saniyeler = [Int]()

        var intSaniyeToplam = [Int]()

        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Ders Süre") as? [String:String] {

                        for (i,_) in datas {
                            derslerArray.append(i)
                        }

                        self.tableView.reloadData()
                    }

                    for i in derslerArray {
                        if let datas = document.get("AYT \(i) Süre") as? [String:String] {

                            for (i,k) in datas {
                                konular.append(i)
                                sureler.append(k)
                            }

                            self.tableView.reloadData()
                        }
                    }

                    

                    for i in sureler {
                        let veriler = i.split(separator: ":")
                        let saat = Int(veriler[0])!
                        let dakika = Int(veriler[1])!
                        let saniye = Int(veriler[2])!

                        saatler.append(saat)
                        dakikalar.append(dakika)
                        saniyeler.append(saniye)
                    }

                    

                    var tur = 0

                    while tur < konular.count {
                        let toplamSaniye = saatler[tur] * 3600 + dakikalar[tur] * 60 + saniyeler[tur] * 1

                        intSaniyeToplam.append(toplamSaniye)

                        tur += 1
                    }
                    
                    // ortalama hesaplama
                    var ortalamaToplam = 0

                    for i in intSaniyeToplam {
                        ortalamaToplam += i
                    }

                    let ortalama = ortalamaToplam / konular.count

                    var ortalamaSaniye = ortalama
                    var ortalamaDakika = 0
                    var ortalamaSaat = 0

                    if ortalamaSaniye >= 60 {
                        let tam = ortalamaSaniye / 60
                        let kalan = ortalamaSaniye - (60 * tam)

                        ortalamaSaniye = kalan
                        ortalamaDakika = tam
                    }

                    if ortalamaDakika >= 60 {
                        let tam = ortalamaDakika / 60
                        let kalan = ortalamaDakika - (60 * tam)

                        ortalamaDakika = kalan
                        ortalamaSaat = tam
                    }

                    var strLazimSaniye = ""
                    var strLazimDakika = ""
                    var strLazimSaat = ""

                    if ortalamaSaat < 10 {
                        strLazimSaat = "0\(ortalamaSaat)"
                    } else {
                        strLazimSaat = "\(ortalamaSaat)"
                    }

                    if ortalamaDakika < 10 {
                        strLazimDakika = "0\(ortalamaDakika)"
                    } else {
                        strLazimDakika = "\(ortalamaDakika)"
                    }

                    if ortalamaSaniye < 10 {
                        strLazimSaniye = "0\(ortalamaSaniye)"
                    } else {
                        strLazimSaniye = "\(ortalamaSaniye)"
                    }

                    let lazimGosterilecekVeri = "\(strLazimSaat):\(strLazimDakika):\(strLazimSaniye)"

                    // ortlaama heasplama bitiş

                    var enBuyukSaniye = intSaniyeToplam[0]
                    var enKucukSaniye = intSaniyeToplam[0]

                    for i in intSaniyeToplam {
                        if i > enBuyukSaniye {
                            enBuyukSaniye = i
                        }
                        if i < enKucukSaniye {
                            enKucukSaniye = i
                        }
                    }

                    let enBuyukIndex = Int(intSaniyeToplam.firstIndex(of: enBuyukSaniye)!)
                    let enKucukIndex = Int(intSaniyeToplam.firstIndex(of: enKucukSaniye)!)

                    let enCokCalisilmisDers = konular[enBuyukIndex]
                    let enAzCalisilmisDers = konular[enKucukIndex]

                    self.detailArray2[6] = enCokCalisilmisDers
                    self.detailArray2[7] = enAzCalisilmisDers
                    self.detailArray2[8] = lazimGosterilecekVeri
                    
                    self.tableView.reloadData()

                    print(intSaniyeToplam)

                } else {
                    print("Document does not exist")
                }
            }
        }
    }

    func tytEnCokAzSoruCozulmusDers() {
        
        var derslerArray = [String]()
        var derslerSoru = [Int]()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Ders Soru") as? [String:String] {
                        for (i,k) in datas {
                            derslerArray.append(i)
                            derslerSoru.append(Int(k)!)
                        }
                        
                        var enCokCozulmusDers = derslerSoru[0]
                        var enAzCozulmusDers = derslerSoru[0]
                        
                        for i in derslerSoru {
                            if i > enCokCozulmusDers {
                                enCokCozulmusDers = i
                            }
                            
                            if i < enAzCozulmusDers {
                                enAzCozulmusDers = i
                            }
                        }
                        
                        // ortalama hesapla
                        
                        var toplam = 0
                        
                        for i in derslerSoru {
                            toplam += i
                        }
                        
                        let ortalama = (toplam) / (derslerArray.count)
                        
                        // ortalama hesapla bitiş
                        
                        let cokDers = derslerArray[derslerSoru.firstIndex(of: enCokCozulmusDers)!]
                        let azDers = derslerArray[derslerSoru.firstIndex(of: enAzCozulmusDers)!]
                        
                        self.detailArray[9] = cokDers
                        self.detailArray[10] = azDers
                        self.detailArray[11] = "\(ortalama)"
                        
                        self.tableView.reloadData()
                    }
                
                } else {
                    print("Document does not exist")
                }
                
                
            }
        }
    }
    
    func aytEnCokAzSoruCozulmusDers() {
        var derslerArray = [String]()
        var derslerSoru = [Int]()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Ders Soru") as? [String:String] {
                        for (i,k) in datas {
                            derslerArray.append(i)
                            derslerSoru.append(Int(k)!)
                        }
                        
                        var enCokCozulmusDers = derslerSoru[0]
                        var enAzCozulmusDers = derslerSoru[0]
                        
                        for i in derslerSoru {
                            if i > enCokCozulmusDers {
                                enCokCozulmusDers = i
                            }
                            
                            if i < enAzCozulmusDers {
                                enAzCozulmusDers = i
                            }
                        }
                        
                        // ortalama hesapla
                        
                        var toplam = 0
                        
                        for i in derslerSoru {
                            toplam += i
                        }
                        
                        let ortalama = (toplam) / (derslerArray.count)
                        
                        // ortalama hesapla bitiş
                        
                        let cokDers = derslerArray[derslerSoru.firstIndex(of: enCokCozulmusDers)!]
                        let azDers = derslerArray[derslerSoru.firstIndex(of: enAzCozulmusDers)!]
                        
                        self.detailArray2[9] = cokDers
                        self.detailArray2[10] = azDers
                        self.detailArray2[11] = "\(ortalama)"
                        
                        self.tableView.reloadData()
                    }
                
                } else {
                    print("Document does not exist")
                }
                
                
            }
        }
    }
    
    func tytEnCokAzSoruCozulmusKonuHesapla() {
        
        var derslerArray = [String]()
        
        var tumKonular = [String]()
        var tumSorular = [Int]()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Ders Soru") as? [String:String] {
                        
                        for (i,_) in datas {
                            derslerArray.append(i)
                        }
                        
                        for i in derslerArray {
                            if let datas = document.get("TYT \(i) Soru") as? [String:String] {
                                
                                for (i,k) in datas {
                                    tumKonular.append(i)
                                    tumSorular.append(Int(k)!)
                                }
                                
                                var enYuksek = tumSorular[0]
                                var enDusuk = tumSorular[0]
                                
                                for i in tumSorular {
                                    if i > enYuksek {
                                        enYuksek = i
                                    }
                                    
                                    if i < enDusuk {
                                        enDusuk = i
                                    }
                                }
                                
                                var toplam = 0
                                
                                for i in tumSorular {
                                    toplam += i
                                }
                                
                                let ortalama = (toplam) / (tumKonular.count)
                                
                                let buyukIndex = Int(tumSorular.firstIndex(of: enYuksek)!)
                                let kucukIndex = Int(tumSorular.firstIndex(of: enDusuk)!)
                                
                                self.detailArray[12] = tumKonular[buyukIndex]
                                self.detailArray[13] = tumKonular[kucukIndex]
                                self.detailArray[14] = "\(ortalama)"
                                
                                self.tableView.reloadData()
                            
                            }
                
                        }
                        
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func aytEnCokAzSoruCozulmusKonuHesapla() {
        
        var derslerArray = [String]()
        
        var tumKonular = [String]()
        var tumSorular = [Int]()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Ders Soru") as? [String:String] {
                        
                        for (i,_) in datas {
                            derslerArray.append(i)
                        }
                        
                        for i in derslerArray {
                            if let datas = document.get("AYT \(i) Soru") as? [String:String] {
                                
                                for (i,k) in datas {
                                    tumKonular.append(i)
                                    tumSorular.append(Int(k)!)
                                }
                                
                                var enYuksek = tumSorular[0]
                                var enDusuk = tumSorular[0]
                                
                                for i in tumSorular {
                                    if i > enYuksek {
                                        enYuksek = i
                                    }
                                    
                                    if i < enDusuk {
                                        enDusuk = i
                                    }
                                }
                                
                                var toplam = 0
                                
                                for i in tumSorular {
                                    toplam += i
                                }
                                
                                let ortalama = (toplam) / (tumKonular.count)
                                
                                let buyukIndex = Int(tumSorular.firstIndex(of: enYuksek)!)
                                let kucukIndex = Int(tumSorular.firstIndex(of: enDusuk)!)
                                
                                self.detailArray2[12] = tumKonular[buyukIndex]
                                self.detailArray2[13] = tumKonular[kucukIndex]
                                self.detailArray2[14] = "\(ortalama)"
                                
                                self.tableView.reloadData()
                            
                            }
                
                        }
                        
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func tytDenemeleriVerileriniHesapla() {
        var gelenDenemelerTumVeriler = [Dictionary<String, String>]()
        
        var denemeSayisi = 0
    
        var toplamNet = [String]()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            var xArray = [String]()
            var yArray = [String]()
            var myDict: [String: String] = [:]
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Denemeleri") as? [String:[String:String]] {
                        for (i,k) in datas {
                            
                            denemeSayisi += 1
                            
                            print("DENEME İD = \(i)")
                            for (x,y) in k {
                                
                                xArray.append(x)
                                
                                yArray.append(y)
                            
                                for (index, element) in xArray.enumerated() {
                                    myDict[element] = yArray[index]
                                }
                            }
                            gelenDenemelerTumVeriler.append(myDict)
                        }
                        
                        
                        for i in gelenDenemelerTumVeriler {
                            toplamNet.append(i["Toplam Net"]!)
                        }
                        
                        var enDusukNet = Double(toplamNet[0])!
                        var enYuksekNet = Double(toplamNet[0])!
                        
                        for i in toplamNet {
                            if Double(i)! > enYuksekNet {
                                enYuksekNet = Double(i)!
                            }
                            
                            if Double(i)! < enDusukNet {
                                enDusukNet = Double(i)!
                            }
                        }
                        
                        // ortalama hesaplama
                        
                        var toplam : Double = 0
                        
                        for i in toplamNet {
                            toplam += Double(i)!
                        }
                        
                        let ortalama = toplam / Double(denemeSayisi)
                        
                        // ortalama hesaplama bitiş
                        
                        self.detailArray[15] = "\(enYuksekNet)"
                        self.detailArray[16] = "\(enDusukNet)"
                        self.detailArray[17] = "\(ortalama)"
                        
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func aytDenemeleriVerileriniHesapla() {
        var gelenDenemelerTumVeriler = [Dictionary<String, String>]()
        
        var denemeSayisi = 0
        
        var toplamNet = [String]()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            var xArray = [String]()
            var yArray = [String]()
            var myDict: [String: String] = [:]
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Denemeleri") as? [String:[String:String]] {
                        for (i,k) in datas {
                            
                            denemeSayisi += 1
                            
                            print("DENEME İD = \(i)")
                            for (x,y) in k {
                                
                                xArray.append(x)
                                
                                yArray.append(y)
                            
                                for (index, element) in xArray.enumerated() {
                                    myDict[element] = yArray[index]
                                }
                            }
                            gelenDenemelerTumVeriler.append(myDict)
                        }
                        
                        
                        for i in gelenDenemelerTumVeriler {
                            toplamNet.append(i["Toplam Net"]!)
                        }
                        
                        var enDusukNet = Double(toplamNet[0])!
                        var enYuksekNet = Double(toplamNet[0])!
                        
                        for i in toplamNet {
                            if Double(i)! > enYuksekNet {
                                enYuksekNet = Double(i)!
                            }
                            
                            if Double(i)! < enDusukNet {
                                enDusukNet = Double(i)!
                            }
                        }
                        
                        // ortalama hesaplama
                        
                        var toplam : Double = 0
                        
                        for i in toplamNet {
                            toplam += Double(i)!
                        }
                        
                        let ortalama = toplam / Double(denemeSayisi)
                        
                        // ortalama hesaplama bitiş
                        
                        self.detailArray2[15] = "\(enYuksekNet)"
                        self.detailArray2[16] = "\(enDusukNet)"
                        self.detailArray2[17] = "\(ortalama)"
                        
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    

}
