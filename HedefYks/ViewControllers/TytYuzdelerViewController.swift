//
//  TytYuzdelerViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 29.03.2021.
//

import UIKit
import Firebase

class TytYuzdelerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var derslerArray = [String]()
    var yüzdelerArray = [Double]()
    
    var seçilenDers = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        getDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return derslerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "yüzdeler1")
        cell.textLabel?.text = derslerArray[indexPath.row]
        cell.detailTextLabel?.text = "\(yüzdelerArray[indexPath.row])%"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        seçilenDers = derslerArray[indexPath.row]
        performSegue(withIdentifier: "toKonuTamamlaVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! KonuTamamlaViewController
        destinationVC.tytOrAyt = "TYT"
        destinationVC.ders = seçilenDers
    }
    
    func getDatas() {
        
        derslerArray.removeAll()
        yüzdelerArray.removeAll()
        
        let db = Firestore.firestore()
        if let userUid = Auth.auth().currentUser?.uid {
            let docRef = db.collection("Users").document(userUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let datas = document.get("TYT Yüzdeler") as? [String:String] {
                        
                        for (i,k) in datas {
                            self.derslerArray.append(i)
                            
                            let x = Double(k)!
                            
                            let y = Double(round(10*x)/10)
                        
                            self.yüzdelerArray.append(y)

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
