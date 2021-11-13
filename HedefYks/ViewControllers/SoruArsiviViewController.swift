//
//  SoruArsiviViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 27.03.2021.
//

import UIKit

class SoruArsiviViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var pendingImagesArray = [UIImage]()
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (view.frame.size.width), height: (view.frame.size.width))
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pendingImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExampleCollectionViewCell
        cell.imageView.image = pendingImagesArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print(indexPath.row)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let button1 = UIAlertAction(title: "Çözüldü Olarak İşaretle", style: UIAlertAction.Style.default) { (UIAlertAction) in
            print("ÇÖZÜLDÜ OLARAK İŞARETLENDİ")
        }
        let button2 = UIAlertAction(title: "Paylaş", style: UIAlertAction.Style.default) { (UIAlertAction) in
            print("PAYLAŞILDI")
        }
        alert.addAction(button2)
        alert.addAction(button1)
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideAlertAction))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func hideAlertAction() {
        self.dismiss(animated: true, completion: nil)
    }

}
