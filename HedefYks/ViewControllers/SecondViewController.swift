//
//  SecondViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControlStatus: UISegmentedControl!
    
    var secilenDers = ""
    
    var anlikIndex = 0
    
    var tytDerslerDizisi = [String]()
    var tytDersSurelerDizisi = [String]()
    
    var aytDerslerDizisi = [String]()
    var aytDersSurelerDizisi = [String]()
    
    var ydtDerslerDizisi = [String]()
    var ydtDersSurelerDizisi = [String]()
    
    var showedLessonArray = [String]()
    var showedLessonTimesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
                
        tableView.delegate = self
        tableView.dataSource = self
  

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        switch anlikIndex {
        case 0:
            tytDerslerVerileriniGetir()
            break
        case 1:
            aytDerslerVerileriniGetir()
            break
        case 2:
            ydtDerslerVerileriniGetir()
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showedLessonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "dersler1")
        cell.textLabel?.text = showedLessonArray[indexPath.row]
        cell.detailTextLabel?.text = showedLessonTimesArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tytDerslerVerileriniGetir() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Ders Süre") as? [String:String] {
                        self.tytDerslerDizisi.removeAll()
                        self.tytDersSurelerDizisi.removeAll()
                        for (i,k) in datas {
                            self.tytDerslerDizisi.append(i)
                            self.tytDersSurelerDizisi.append(k)
                        }
                        self.showedLessonArray = self.tytDerslerDizisi
                        self.showedLessonTimesArray = self.tytDersSurelerDizisi
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    func aytDerslerVerileriniGetir() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("AYT Ders Süre") as? [String:String] {
                        self.aytDerslerDizisi.removeAll()
                        self.aytDersSurelerDizisi.removeAll()
                        for (i,k) in datas {
                            self.aytDerslerDizisi.append(i)
                            self.aytDersSurelerDizisi.append(k)
                        }
                        self.showedLessonArray = self.aytDerslerDizisi
                        self.showedLessonTimesArray = self.aytDersSurelerDizisi
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    func ydtDerslerVerileriniGetir() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("YDT Ders Süre") as? [String:String] {
                        self.ydtDerslerDizisi.removeAll()
                        self.ydtDersSurelerDizisi.removeAll()
                        for (i,k) in datas {
                            self.ydtDerslerDizisi.append(i)
                            self.ydtDersSurelerDizisi.append(k)
                        }
                        self.showedLessonArray = self.ydtDerslerDizisi
                        self.showedLessonTimesArray = self.ydtDersSurelerDizisi
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        secilenDers = self.showedLessonArray[indexPath.row]
        performSegue(withIdentifier: "toKonular1VC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toKonular1VC" {
            let destinationVC = segue.destination as! Konular1ViewController
            if self.anlikIndex == 0 {
                destinationVC.tytOrAytOrYdt = "TYT"
                destinationVC.navigasyonBasligi = "TYT \(secilenDers)"
            } else if self.anlikIndex == 1 {
                destinationVC.tytOrAytOrYdt = "AYT"
                destinationVC.navigasyonBasligi = "AYT \(secilenDers)"
            } else {
                destinationVC.tytOrAytOrYdt = "YDT"
                destinationVC.navigasyonBasligi = "YDT \(secilenDers)"
            }
        }
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            anlikIndex = 0
            tytDerslerVerileriniGetir()
            break
        case 1:
            anlikIndex = 1
            aytDerslerVerileriniGetir()
            break
        case 2:
            anlikIndex = 2
            ydtDerslerVerileriniGetir()
            break
        default:
            break
        }
    }
    
    @IBAction func tamamlaButtonClicked(_ sender: Any) {
        if anlikIndex == 0 {
            performSegue(withIdentifier: "toTytTamamlananDerslerVC", sender: nil)
        } else if anlikIndex == 1 {
            performSegue(withIdentifier: "toAytTamamlananDerslerVC", sender: nil)
        }
    }
}
