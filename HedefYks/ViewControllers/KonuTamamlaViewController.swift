//
//  KonuTamamlaViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 29.03.2021.
//

import UIKit
import Firebase

class KonuTamamlaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tytOrAyt = ""
    var ders = ""
    
    var konularArray = [String]()
    var switchValueArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        
        getDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return konularArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = konularArray[indexPath.row]

        //here is programatically switch make to the table view
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        if switchValueArray[indexPath.row] == "0" {
            switchView.isOn = false
        } else {
            switchView.isOn = true
        }
        
        cell.accessoryView = switchView
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        var switchValue = switchValueArray[sender.tag]
        if switchValue == "0" {
            switchValue = "1"
            switchValueArray[sender.tag] = "1"
            print(switchValueArray)
            saveDatas()
        } else {
            switchValue = "0"
            switchValueArray[sender.tag] = "0"
            print(switchValueArray)
            saveDatas()
        }
    }
    
    func getDatas() {
        if tytOrAyt == "TYT" {
            let db = Firestore.firestore()
            if let userUid = Auth.auth().currentUser?.uid {
                let docRef = db.collection("Users").document(userUid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let datas = document.get("TYT \(self.ders) Switch") as? [String:String] {
                            
                            for (i,k) in datas {
                                self.konularArray.append(i)
                                self.switchValueArray.append(k)
                            }
                            
                            print(self.konularArray)
                            print(self.switchValueArray)
                            
                            self.tableView.reloadData()
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }
        
        if tytOrAyt == "AYT" {
            let db = Firestore.firestore()
            if let userUid = Auth.auth().currentUser?.uid {
                let docRef = db.collection("Users").document(userUid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let datas = document.get("AYT \(self.ders) Switch") as? [String:String] {
                            
                            for (i,k) in datas {
                                self.konularArray.append(i)
                                self.switchValueArray.append(k)
                            }
                            
                            print(self.konularArray)
                            print(self.switchValueArray)
                            
                            self.tableView.reloadData()
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }
    }
    
    func saveDatas() {
        if tytOrAyt == "TYT" {
            let db = Firestore.firestore()
            if let userUid = Auth.auth().currentUser?.uid {
                
                var dictionary: [String: String] = [:]

                for (index, element) in self.konularArray.enumerated() {
                    dictionary[element] = self.switchValueArray[index]
                }
                
                db.collection("Users").document(userUid).setData(["TYT \(self.ders) Switch":dictionary], merge: true)
                
                var toplam = 0
                
                for i in switchValueArray {
                    toplam += Int(i)!
                }
                
                let yüzde : Double = (Double(toplam) / Double(self.konularArray.count)) * 100
                
                db.collection("Users").document(userUid).setData(["TYT Yüzdeler":[self.ders:"\(yüzde)"]], merge: true)
            }
        }
        
        if tytOrAyt == "AYT" {
            let db = Firestore.firestore()
            if let userUid = Auth.auth().currentUser?.uid {
                
                var dictionary: [String: String] = [:]

                for (index, element) in self.konularArray.enumerated() {
                    dictionary[element] = self.switchValueArray[index]
                }
                
                db.collection("Users").document(userUid).setData(["AYT \(self.ders) Switch":dictionary], merge: true)
                
                var toplam = 0
                
                for i in switchValueArray {
                    toplam += Int(i)!
                }
                
                let yüzde : Double = (Double(toplam) / Double(self.konularArray.count)) * 100
                
                db.collection("Users").document(userUid).setData(["AYT Yüzdeler":[self.ders:"\(yüzde)"]], merge: true)
            }
        }
    }
    
    
    
    
    

}
