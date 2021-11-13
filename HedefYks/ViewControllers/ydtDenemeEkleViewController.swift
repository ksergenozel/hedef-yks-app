//
//  ydtDenemeEkleViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 23.03.2021.
//

import UIKit

class ydtDenemeEkleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}
