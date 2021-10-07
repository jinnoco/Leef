//
//  SupportPageViewController.swift
//  Leef
//
//  Created by J on 2021/08/24.
//

import UIKit
import Firebase
import Lottie
import SoftUIView


class SupportPageViewController: UIViewController {
    
    var color = MainColor()
    
    //UI
    var animationView = AnimationView()
    let tosButton = SoftUIView() //利用規約
    let privacyPolicyButton = SoftUIView() //プライバシーポリシー
    let reportButton = SoftUIView() //通報ページ
    let contactButton = SoftUIView() //お問い合わせ
    
    
    
    override func loadView() {
        super.loadView()
        
        configureAnimation()
        configureTOSButton()
        configurePrivacyPolicyButton()
        configureReportButton()
        configureContactButton()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = color.backColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = color.backColor
        
        animationView.play()
        
    }
    
    
    func configureAnimation() {
        animationView = AnimationView(name: "41384-customer-support-animation")
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        setAnimationView()
    }
    
    
    func configureTOSButton() {
        view.addSubview(tosButton)
        tosButton.mainColor = color.backColor.cgColor
        tosButton.darkShadowColor = color.darkShadow.cgColor
        tosButton.lightShadowColor = color.lightShadow.cgColor
        tosButton.cornerRadius = 20
        //Button内にLabelを配置
        let label = UILabel()
        tosButton.setContentView(label)
        label.text = "利用規約"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: tosButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: tosButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
        tosButton.addTarget(self, action: #selector(toTOSPage), for: .touchUpInside)
        setTOSButton()
    }
    
    
 
    func configurePrivacyPolicyButton() {
        view.addSubview(privacyPolicyButton)
        privacyPolicyButton.mainColor = color.backColor.cgColor
        privacyPolicyButton.darkShadowColor = color.darkShadow.cgColor
        privacyPolicyButton.lightShadowColor = color.lightShadow.cgColor
        privacyPolicyButton.cornerRadius = 20
        //Button内にLabelを配置
        let label = UILabel()
        privacyPolicyButton.setContentView(label)
        label.text = "プライバシーポリシー"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: privacyPolicyButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: privacyPolicyButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
        privacyPolicyButton.addTarget(self, action: #selector(toPrivacyPolicyPage), for: .touchUpInside)
        setPrivacyPolicyButton()
    }
    
   
    
    func configureReportButton() {
        view.addSubview(reportButton)
        reportButton.mainColor = color.backColor.cgColor
        reportButton.darkShadowColor = color.darkShadow.cgColor
        reportButton.lightShadowColor = color.lightShadow.cgColor
        reportButton.cornerRadius = 20
        //Button内にLabelを配置
        let label = UILabel()
        reportButton.setContentView(label)
        label.text = "ユーザー通報"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: reportButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: reportButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
        reportButton.addTarget(self, action: #selector(toReportPage), for: .touchUpInside)
        setReportButton()
    }
    
    
    
    func configureContactButton() {
        view.addSubview(contactButton)
        contactButton.mainColor = color.backColor.cgColor
        contactButton.darkShadowColor = color.darkShadow.cgColor
        contactButton.lightShadowColor = color.lightShadow.cgColor
        contactButton.cornerRadius = 20
        //Button内にLabelを配置
        let label = UILabel()
        contactButton.setContentView(label)
        label.text = "お問い合わせ"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contactButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
        contactButton.addTarget(self, action: #selector(toContactPage), for: .touchUpInside)
        setContactButton()
    }
    
    
    
    func setAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints                             = false
        let width = view.frame.size.width / 2
        let height = view.frame.size.height / 3
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive        = true
        animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive  = true
        animationView.widthAnchor.constraint(equalToConstant: width).isActive               = true
        animationView.heightAnchor.constraint(equalToConstant: height).isActive             = true
        
    }
    
    func setTOSButton() {
        tosButton.translatesAutoresizingMaskIntoConstraints                                         = false
        tosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        tosButton.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20).isActive  = true
        tosButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        tosButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    func setPrivacyPolicyButton() {
        privacyPolicyButton.translatesAutoresizingMaskIntoConstraints                                       = false
        privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        privacyPolicyButton.topAnchor.constraint(equalTo: tosButton.bottomAnchor,  constant: 20).isActive   = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    
    func setReportButton() {
        reportButton.translatesAutoresizingMaskIntoConstraints                                                  = false
        reportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                             = true
        reportButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor,  constant: 20).isActive    = true
        reportButton.widthAnchor.constraint(equalToConstant: 250).isActive                                      = true
        reportButton.heightAnchor.constraint(equalToConstant: 40).isActive                                      = true
    }
    
    func setContactButton() {
        contactButton.translatesAutoresizingMaskIntoConstraints                                         = false
        contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        contactButton.topAnchor.constraint(equalTo: reportButton.bottomAnchor,  constant: 20).isActive  = true
        contactButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        contactButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    
    
    //外部ブラウザに画面遷移
    
    @objc func toTOSPage() {
        let url = NSURL(string: "https://site-2671642-9203-8355.mystrikingly.com")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func toPrivacyPolicyPage() {
        let url = NSURL(string: "https://site-2671642-386-3077.mystrikingly.com")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func toReportPage() {
        let url = NSURL(string: "https://site-2671642-9832-2847.mystrikingly.com")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    //Twitterアカウントに遷移
    @objc func toContactPage() {
        let url = NSURL(string: "https://twitter.com/LeefApp_")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    
}
