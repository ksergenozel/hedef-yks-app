//
//  SitelerViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 1.04.2021.
//

import UIKit
import Firebase

class SitelerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var webSitesArray = [String]()
    var descriptionArray = [String]()
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
        return webSitesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "instagram")
        cell.textLabel?.text = webSitesArray[indexPath.row]
        cell.detailTextLabel?.text = descriptionArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.detailTextLabel?.font = .systemFont(ofSize: CGFloat(15))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: "\(self.urlArray[indexPath.row])") else { return }
        UIApplication.shared.open(url)
    }
    
    func getDatas() {
        webSitesArray.removeAll()
        descriptionArray.removeAll()
        urlArray.removeAll()
        
        let db = Firestore.firestore()
        let docRef = db.collection("İnternet Adresleri").document("İnternet Adresleri")
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let datas = document.get("Adres") as? [String] {
                        
                    for i in datas {
                        self.webSitesArray.append(i)
                    }
                    
                }
                
                if let datas = document.get("Açıklama") as? [String] {
                        
                    for i in datas {
                        self.descriptionArray.append(i)
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
