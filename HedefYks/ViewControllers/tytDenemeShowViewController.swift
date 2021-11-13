//
//  tytDenemeShowViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 24.03.2021.
//

import UIKit

class tytDenemeShowViewController: UIViewController {

    var denemeAdi = ""
    var turkceDogruSayisi = ""
    var turkceYanlisSayisi = ""
    var turkceBosSayisi = ""
    var sosyalDogruSayisi = ""
    var sosyalYanlisSayisi = ""
    var sosyalBosSayisi = ""
    var matematikDogruSayisi = ""
    var matematikYanlisSayisi = ""
    var matematikBosSayisi = ""
    var fenDogruSayisi = ""
    var fenYanlisSayisi = ""
    var fenBosSayisi = ""
    var turkceNeti = ""
    var sosyalNeti = ""
    var matematikNeti = ""
    var fenNeti = ""
    var toplamNet = ""
    
    @IBOutlet weak var turkceDogruTextField: UITextField!
    @IBOutlet weak var turkceYanlisTextField: UITextField!
    @IBOutlet weak var turkceBosTextField: UITextField!
    
    @IBOutlet weak var sosyalDogruTextField: UITextField!
    @IBOutlet weak var sosyalYanlisTextField: UITextField!
    @IBOutlet weak var sosyalBosTextField: UITextField!
    
    @IBOutlet weak var matematikDogruTextField: UITextField!
    @IBOutlet weak var matematikYanlisTextField: UITextField!
    @IBOutlet weak var matematikBosTextField: UITextField!
    
    @IBOutlet weak var fenDogruTextField: UITextField!
    @IBOutlet weak var fenYanlisTextField: UITextField!
    @IBOutlet weak var fenBosTextField: UITextField!
    
    @IBOutlet weak var turkceNetTextField: UITextField!
    @IBOutlet weak var sosyalNetTextField: UITextField!
    @IBOutlet weak var matematikNetTextField: UITextField!
    @IBOutlet weak var fenNetTextField: UITextField!
    
    @IBOutlet weak var toplamNetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        turkceDogruTextField.text = turkceDogruSayisi
        turkceYanlisTextField.text = turkceYanlisSayisi
        turkceBosTextField.text = turkceBosSayisi
        
        sosyalDogruTextField.text = sosyalDogruSayisi
        sosyalYanlisTextField.text = sosyalYanlisSayisi
        sosyalBosTextField.text = sosyalBosSayisi
        
        matematikDogruTextField.text = matematikDogruSayisi
        matematikYanlisTextField.text = matematikYanlisSayisi
        matematikBosTextField.text = matematikBosSayisi
        
        fenDogruTextField.text = fenDogruSayisi
        fenYanlisTextField.text = fenYanlisSayisi
        fenBosTextField.text = fenBosSayisi
        
        turkceNetTextField.text = turkceNeti
        sosyalNetTextField.text = sosyalNeti
        matematikNetTextField.text = matematikNeti
        fenNetTextField.text = fenNeti
        
        toplamNetTextField.text = toplamNet
    }
    
}
