//
//  FifthViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 21.03.2021.
//

import UIKit
import Firebase
import MessageUI
import StoreKit

class FifthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    let mainArray : [String] = ["Duyurular","Sınava Geri Sayım","Önerdiğimiz Youtube Kanalları","Önerdiğimiz Kaynak Kitaplar","Kullanıcılarımıza Özel Teklifler","Önerdiğimiz Instagram Hesapları","Önerdiğimiz İnternet Siteleri","Bizimle İletişime Geçin","Uygulamaya Yıldız Verin","İş Birliği Yapalım","Kullanıcı Sözleşmemiz","Gizlilik Politikamız"]
    
    let detailArray : [String] = ["Sınavla ilgili gelişmelerden haberdar olun.","Ne kadar süreniz kaldığını öğrenin.","Ders videoları izleyerek sınava hazırlanın.","Kullanıcılarımız tarafından tavsiye edilenler.","Size özel indirimlerden yararlanın.","Size faydalı olabilecek hesapları takip edin.","Kullanıcılarımızın sık ziyaret ettiği siteler.","Düşüncelerinizi bizimle paylaşın.","Uygulamayı başkalarına önerin.","Reklam vermek için bize ulaşın.","",""]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "Duyurular", sender: nil)
        }
        
        if indexPath.row == 1 {
            performSegue(withIdentifier: "GeriSayim", sender: nil)
        }
        
        if indexPath.row == 2 {
            performSegue(withIdentifier: "Youtube", sender: nil)
        }
        
        if indexPath.row == 3 {
            performSegue(withIdentifier: "Kaynaklar", sender: nil)
        }
        
        if indexPath.row == 4 {
            performSegue(withIdentifier: "Teklifler", sender: nil)
        }
        
        if indexPath.row == 5 {
            performSegue(withIdentifier: "toInstagramVC", sender: nil)
        }
        
        if indexPath.row == 6 {
            performSegue(withIdentifier: "Siteler", sender: nil)
        }
        
        if indexPath.row == 7 {
            sendEmail(subject: "Uygulama Ekibine İletmek İstediğim Düşünceler")
        }
        
        if indexPath.row == 8 {
            rateApp()
        }
        
        if indexPath.row == 9 {
            sendEmail(subject: "Uygulama Ekibine İletmek İstediğim İş Birliği Teklifi")
        }
        
        if indexPath.row == 10 {
            guard let url = URL(string: "https://sites.google.com/view/wakeguard-app/terms-conditions") else { return }
            UIApplication.shared.open(url)
        }
        
        if indexPath.row == 11 {
            guard let url = URL(string: "https://sites.google.com/view/wakeguard-app/privacy-policy") else { return }
            UIApplication.shared.open(url)
        }
    }
    
    func rateApp() {
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            SKStoreReviewController.requestReview(in: scene)
//        }
        
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
        
    }
    
    func sendEmail(subject:String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["ksergenozel@gmail.com"])
            mail.setSubject(subject)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = mainArray[indexPath.row]
        cell.detailTextLabel?.text = detailArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.detailTextLabel?.font = .systemFont(ofSize: CGFloat(15))
        return cell
    }

    @IBAction func cikisYapClicked(_ sender: Any) {
        logOutAction()
    }
        
    func logOutAction() {
        let alert = UIAlertController(title: "Uyarı", message: "Çıkış yapmak üzeresiniz. Bunu onaylıyor musunuz?", preferredStyle: UIAlertController.Style.alert)
        let yesButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { (UIAlertAction) in
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toViewController", sender: nil)
            } catch {
                print("error")
            }
        }
        let noButton = UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(noButton)
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
