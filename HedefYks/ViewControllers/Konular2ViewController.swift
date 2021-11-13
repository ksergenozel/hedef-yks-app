//
//  Konular2ViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 23.03.2021.
//

import UIKit
import Firebase

class Konular2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var navigasyonBasligi = "Konular"
    var tytOrAytOrYdt = ""
    
    var secilenKonu = ""
    var secilenKonuMevcutSoru = ""
    
    var konular : [String] = []
    var sorular : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = navigasyonBasligi
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        konuVerileriniGetir()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        konuVerileriniGetir()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationFunction), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func notificationFunction() {
        konuVerileriniGetir()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return konular.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "konular2")
        cell.textLabel?.text = konular[indexPath.row]
        cell.detailTextLabel?.text = sorular[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func konuVerileriniGetir() {
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("\(self.navigasyonBasligi) Soru") as? [String:String] {
                        self.konular.removeAll()
                        self.sorular.removeAll()
                        for (i,k) in datas {
                            self.konular.append(i)
                            self.sorular.append(k)
                        }
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
        self.secilenKonu = konular[indexPath.row]
        self.secilenKonuMevcutSoru = sorular[indexPath.row]
        self.performSegue(withIdentifier: "toCalis2VC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCalis2VC" {
            let destinationVC = segue.destination as! Calis2ViewController
            //destinationVC.navigasyonBasligi = self.secilenKonu
            destinationVC.mevcutSoru = self.secilenKonuMevcutSoru
            destinationVC.mevcutDers = self.navigasyonBasligi
            destinationVC.mevcutKonu = self.secilenKonu
        }
    }
}
