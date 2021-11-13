//
//  FourthViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase

class FourthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControlStatus: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    
    var anlikIndex = 0
    
    var gelenDenemelerTumVeriler = [Dictionary<String, String>]()
    
    var gelenDenemeler = [String]()
    
    var gelenDenemeId = [String]()
    
    // TYT DENEMESİ İÇİN
    var denemeAdi = [String]()
    var turkceDogruSayisi = [String]()
    var turkceYanlisSayisi = [String]()
    var turkceBosSayisi = [String]()
    var sosyalDogruSayisi = [String]()
    var sosyalYanlisSayisi = [String]()
    var sosyalBosSayisi = [String]()
    var matematikDogruSayisi = [String]()
    var matematikYanlisSayisi = [String]()
    var matematikBosSayisi = [String]()
    var fenDogruSayisi = [String]()
    var fenYanlisSayisi = [String]()
    var fenBosSayisi = [String]()
    var turkceNeti = [String]()
    var sosyalNeti = [String]()
    var matematikNeti = [String]()
    var fenNeti = [String]()
    
    // ayt gelen deneme türü
    var aytGelenDenemeTuru = [String]()
    
    // hepsinde ortak sürekli yenileniyor
    var toplamNet = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        index = 0
        
        gelenDenemeler = [String]()
        gelenDenemelerTumVeriler = [Dictionary<String, String>]()
        toplamNet = [String]()
        
        gelenDenemeId = [String]()
        
        denemeAdi = [String]()
        turkceDogruSayisi = [String]()
        turkceYanlisSayisi = [String]()
        turkceBosSayisi = [String]()
        sosyalDogruSayisi = [String]()
        sosyalYanlisSayisi = [String]()
        sosyalBosSayisi = [String]()
        matematikDogruSayisi = [String]()
        matematikYanlisSayisi = [String]()
        matematikBosSayisi = [String]()
        fenDogruSayisi = [String]()
        fenYanlisSayisi = [String]()
        fenBosSayisi = [String]()
        turkceNeti = [String]()
        sosyalNeti = [String]()
        matematikNeti = [String]()
        fenNeti = [String]()
        
        aytGelenDenemeTuru = [String]()
        
        switch anlikIndex {
        case 0:
            tytDenemeleriniGetir()
            break
        case 1:
            aytDenemeleriniGetir()
            break
        case 2:
            
            break
        default:
            break
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gelenDenemeler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "denemeler")
        cell.textLabel?.text = gelenDenemeler[indexPath.row]
        cell.detailTextLabel?.text = toplamNet[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if anlikIndex == 0 {
            index = indexPath.row
            performSegue(withIdentifier: "toTytDenemeShowVC", sender: nil)
        } else if anlikIndex == 1 {
            if self.aytGelenDenemeTuru[indexPath.row] == "Eşit Ağırlık" {
                index = indexPath.row
                performSegue(withIdentifier: "toEaDenemeShowVC", sender: nil)
            } else if self.aytGelenDenemeTuru[indexPath.row] == "Sayısal" {
                index = indexPath.row
                performSegue(withIdentifier: "toSaDenemeShowVC", sender: nil)
            } else if self.aytGelenDenemeTuru[indexPath.row] == "Sözel" {
                index = indexPath.row
                performSegue(withIdentifier: "toSoDenemeShowVC", sender: nil)
            }
        } else {
            // burası ydt için
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTytDenemeShowVC" {
            let destinationVC = segue.destination as! tytDenemeShowViewController
            
            destinationVC.denemeAdi = self.denemeAdi[index]
            destinationVC.turkceDogruSayisi = self.turkceDogruSayisi[index]
            destinationVC.turkceYanlisSayisi = self.turkceYanlisSayisi[index]
            destinationVC.turkceBosSayisi = self.turkceBosSayisi[index]
            destinationVC.sosyalDogruSayisi = self.sosyalDogruSayisi[index]
            destinationVC.sosyalYanlisSayisi = self.sosyalYanlisSayisi[index]
            destinationVC.sosyalBosSayisi = self.sosyalBosSayisi[index]
            destinationVC.matematikDogruSayisi = self.matematikDogruSayisi[index]
            destinationVC.matematikYanlisSayisi = self.matematikYanlisSayisi[index]
            destinationVC.matematikBosSayisi = self.matematikBosSayisi[index]
            destinationVC.fenDogruSayisi = self.fenDogruSayisi[index]
            destinationVC.fenYanlisSayisi = self.fenYanlisSayisi[index]
            destinationVC.fenBosSayisi = self.fenBosSayisi[index]
            destinationVC.turkceNeti = self.turkceNeti[index]
            destinationVC.sosyalNeti = self.sosyalNeti[index]
            destinationVC.matematikNeti = self.matematikNeti[index]
            destinationVC.fenNeti = self.fenNeti[index]
            destinationVC.toplamNet = self.toplamNet[index]
        }
        if segue.identifier == "toEaDenemeShowVC" {
            let destinationVC = segue.destination as! eaDenemeShowViewController
            destinationVC.gelenId = self.gelenDenemeId[index]
        }
        if segue.identifier == "toSaDenemeShowVC" {
            let destinationVC = segue.destination as! saDenemeShowViewController
            destinationVC.gelenId = self.gelenDenemeId[index]
        }
        if segue.identifier == "toSoDenemeShowVC" {
            let destinationVC = segue.destination as! soDenemeShowViewController
            destinationVC.gelenId = self.gelenDenemeId[index]
        }
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            index = 0
            anlikIndex = 0
            gelenDenemeler.removeAll()
            toplamNet.removeAll()
            tytDenemeleriniGetir()
            tableView.reloadData()
            break
        case 1:
            index = 0
            anlikIndex = 1
            gelenDenemeId.removeAll()
            gelenDenemeler.removeAll()
            toplamNet.removeAll()
            aytGelenDenemeTuru.removeAll()
            aytDenemeleriniGetir()
            tableView.reloadData()
            break
        case 2:
            index = 0
            anlikIndex = 2
            gelenDenemeler.removeAll()
            toplamNet.removeAll()
            
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        switch anlikIndex {
        case 0:
            performSegue(withIdentifier: "tytDenemeEkle", sender: nil)
            break
        case 1:
            performSegue(withIdentifier: "aytDenemeEkle", sender: nil)
            break
        case 2:
            performSegue(withIdentifier: "ydtDenemeEkle", sender: nil)
            break
        default:
            break
        }
    }
    
    func tytDenemeleriniGetir() {
        
        gelenDenemeler = [String]()
        gelenDenemelerTumVeriler = [Dictionary<String, String>]()
        
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
                            print("DENEME İD = \(i)")
                            for (x,y) in k {
                                
                                xArray.append(x)
                                
                                yArray.append(y)
                            
                                for (index, element) in xArray.enumerated() {
                                    myDict[element] = yArray[index]
                                }
                            }
                            self.gelenDenemelerTumVeriler.append(myDict)
                        }
                        for i in self.gelenDenemelerTumVeriler {
                            self.gelenDenemeler.append(i["Deneme Adı"]!)
                            
                            self.denemeAdi.append(i["Deneme Adı"]!)
                            self.turkceDogruSayisi.append(i["Türkçe Doğru Sayısı"]!)
                            self.turkceYanlisSayisi.append(i["Türkçe Yanlış Sayısı"]!)
                            self.turkceBosSayisi.append(i["Türkçe Boş Sayısı"]!)
                            self.sosyalDogruSayisi.append(i["Sosyal Doğru Sayısı"]!)
                            self.sosyalYanlisSayisi.append(i["Sosyal Yanlış Sayısı"]!)
                            self.sosyalBosSayisi.append(i["Sosyal Boş Sayısı"]!)
                            self.matematikDogruSayisi.append(i["Matematik Doğru Sayısı"]!)
                            self.matematikYanlisSayisi.append(i["Matematik Yanlış Sayısı"]!)
                            self.matematikBosSayisi.append(i["Matematik Boş Sayısı"]!)
                            self.fenDogruSayisi.append(i["Fen Doğru Sayısı"]!)
                            self.fenYanlisSayisi.append(i["Fen Yanlış Sayısı"]!)
                            self.fenBosSayisi.append(i["Fen Boş Sayısı"]!)
                            self.turkceNeti.append(i["Türkçe Neti"]!)
                            self.sosyalNeti.append(i["Sosyal Neti"]!)
                            self.matematikNeti.append(i["Matematik Neti"]!)
                            self.fenNeti.append(i["Fen Neti"]!)
                            self.toplamNet.append(i["Toplam Net"]!)
                        }
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func aytDenemeleriniGetir() {
        
        gelenDenemeler = [String]()
        gelenDenemelerTumVeriler = [Dictionary<String, String>]()
        
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
                            self.gelenDenemeId.append(i)
                            for (x,y) in k {
                                
                                xArray.append(x)
                                
                                yArray.append(y)
                            
                                for (index, element) in xArray.enumerated() {
                                    myDict[element] = yArray[index]
                                }
                            }
                            self.gelenDenemelerTumVeriler.append(myDict)
                        }
                        for i in self.gelenDenemelerTumVeriler {
                            
                            self.aytGelenDenemeTuru.append(i["Deneme Türü"]!)
                            self.gelenDenemeler.append(i["Deneme Adı"]!)
                            
                            if i["Deneme Türü"] == "Eşit Ağırlık" {
                                
                                self.toplamNet.append(i["Toplam Net"]!)
                                
                                print("eşit ağırlık denemesi")
                                
                            } else if i["Deneme Türü"] == "Sayısal" {
                                
                                self.toplamNet.append(i["Toplam Net"]!)
                                
                                print("sayısal denemesi")
                                
                            } else if i["Deneme Türü"] == "Sözel" {
                                
                                self.toplamNet.append(i["Toplam Net"]!)
                                
                                print("sözel denemesi")
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
}
