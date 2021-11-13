//
//  KaynaklarViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 30.03.2021.
//

import UIKit
import Firebase

class KaynaklarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var kitaplar = [String]()
    var dersler = [String]()
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kitaplar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "kitap")
        cell.textLabel?.text = kitaplar[indexPath.row]
        cell.detailTextLabel?.text = dersler[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: "\(self.urlArray[indexPath.row])") else { return }
        UIApplication.shared.open(url)
        
//        let alert = UIAlertController(title: "Uyarı", message: "\(kanallar[indexPath.row]) kanalına gitmek istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.alert)
//        let gitButton = UIAlertAction(title: "Git", style: UIAlertAction.Style.default) { (UIAlertAction) in
//            guard let url = URL(string: "\(self.urlArray[indexPath.row])") else { return }
//            UIApplication.shared.open(url)
//        }
//        let vazgecButton = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
//        alert.addAction(vazgecButton)
//        alert.addAction(gitButton)
//        self.present(alert, animated: true, completion: nil)
    }
    
    func getDatas() {
        kitaplar.removeAll()
        dersler.removeAll()
        urlArray.removeAll()
        
        let db = Firestore.firestore()
        let docRef = db.collection("Kaynak Kitaplar").document("Kaynak Kitaplar")
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let datas = document.get("Kitap İsmi") as? [String] {
                        
                    for i in datas {
                        self.kitaplar.append(i)
                    }
                    
                }
                
                if let datas = document.get("Ders") as? [String] {
                        
                    for i in datas {
                        self.dersler.append(i)
                    }
                        
                    
                }
                
                if let datas = document.get("URL") as? [String] {
                        
                    for i in datas {
                        self.urlArray.append(i)
                    }
                        
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
