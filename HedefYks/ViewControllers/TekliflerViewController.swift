//
//  TekliflerViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 31.03.2021.
//

import UIKit
import Firebase

class TekliflerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var teklifler = [String]()
    var miktarlar = [String]()
    var urlArray = [String]()
    var kod = [String]()
    
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
        return teklifler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "kitap")
        cell.textLabel?.text = teklifler[indexPath.row]
        cell.detailTextLabel?.text = miktarlar[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        guard let url = URL(string: "\(self.urlArray[indexPath.row])") else { return }
//        UIApplication.shared.open(url)
        
        let alert = UIAlertController(title: "\(kod[indexPath.row])", message: "\(teklifler[indexPath.row]) teklifimizden yararlanmak üzeresiniz. Kodunuzu kullanmak için ilgili internet adresine gitmek istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        let gitButton = UIAlertAction(title: "Git", style: UIAlertAction.Style.default) { (UIAlertAction) in
            guard let url = URL(string: "\(self.urlArray[indexPath.row])") else { return }
            UIApplication.shared.open(url)
        }
        let vazgecButton = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(vazgecButton)
        alert.addAction(gitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDatas() {
        teklifler.removeAll()
        miktarlar.removeAll()
        urlArray.removeAll()
        
        let db = Firestore.firestore()
        let docRef = db.collection("Özel Teklifler").document("Özel Teklifler")
            
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let datas = document.get("Teklif") as? [String] {
                        
                    for i in datas {
                        self.teklifler.append(i)
                    }
                    
                }
                
                if let datas = document.get("Miktar") as? [String] {
                        
                    for i in datas {
                        self.miktarlar.append(i)
                    }
                        
                    
                }
                
                if let datas = document.get("URL") as? [String] {
                        
                    for i in datas {
                        self.urlArray.append(i)
                    }
                        
                    
                }
                
                if let datas = document.get("Kod") as? [String] {
                        
                    for i in datas {
                        self.kod.append(i)
                    }
                        
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("Document does not exist")
            }
        }
    }

}
