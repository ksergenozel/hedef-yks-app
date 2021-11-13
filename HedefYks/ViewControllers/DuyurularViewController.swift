//
//  DuyurularViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 30.03.2021.
//

import UIKit
import Firebase

class DuyurularViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var duyuruBaslik = [String]()
    var duyuruIcerik = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        //tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duyuruBaslik.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "duyuru")
        cell.textLabel?.text = duyuruBaslik.reversed()[indexPath.row]
        cell.detailTextLabel?.text = duyuruIcerik.reversed()[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.detailTextLabel?.font = .systemFont(ofSize: CGFloat(15))
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        let alert = UIAlertController(title: duyuruBaslik.reversed()[indexPath.row], message: duyuruIcerik.reversed()[indexPath.row], preferredStyle: UIAlertController.Style.alert)
//        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
//        alert.addAction(okButton)
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: duyuruBaslik.reversed()[indexPath.row], message: duyuruIcerik.reversed()[indexPath.row], preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Anladım", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDatas() {
        duyuruBaslik.removeAll()
        duyuruIcerik.removeAll()
        
        let db = Firestore.firestore()
        let docRef = db.collection("Duyurular").document("Duyurular")
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let datas = document.get("Duyuru Başlık") as? [String] {
                        
                    for i in datas {
                        self.duyuruBaslik.append(i)
                    }
                    
                }
                
                if let datas = document.get("Duyuru İçerik") as? [String] {
                        
                    for i in datas {
                        self.duyuruIcerik.append(i)
                    }
                        
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
