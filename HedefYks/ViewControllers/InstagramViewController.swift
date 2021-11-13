//
//  InstagramViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 31.03.2021.
//

import UIKit
import Firebase

class InstagramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var accountNamesArray = [String]()
    var lessonsArray = [String]()
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
        return accountNamesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "instagram")
        cell.textLabel?.text = accountNamesArray[indexPath.row]
        cell.detailTextLabel?.text = lessonsArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: "\(self.urlArray[indexPath.row])") else { return }
        UIApplication.shared.open(url)
    }
    
    func getDatas() {
        accountNamesArray.removeAll()
        lessonsArray.removeAll()
        urlArray.removeAll()
        
        let db = Firestore.firestore()
        let docRef = db.collection("Instagram Hesapları").document("Instagram Hesapları")
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let datas = document.get("Hesap") as? [String] {
                        
                    for i in datas {
                        self.accountNamesArray.append(i)
                    }
                    
                }
                
                if let datas = document.get("Ders") as? [String] {
                        
                    for i in datas {
                        self.lessonsArray.append(i)
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
