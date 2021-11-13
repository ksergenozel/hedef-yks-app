//
//  YoutubeViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 30.03.2021.
//

import UIKit
import Firebase

class YoutubeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var kanallar = [String]()
    var dersler = [String]()
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanallar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "youtube")
        cell.textLabel?.text = kanallar[indexPath.row]
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
        kanallar.removeAll()
        dersler.removeAll()
        urlArray.removeAll()
        
        let db = Firestore.firestore()
        let docRef = db.collection("Youtube Kanalları").document("Youtube Kanalları")
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let datas = document.get("Kanal İsmi") as? [String] {
                        
                    for i in datas {
                        self.kanallar.append(i)
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
