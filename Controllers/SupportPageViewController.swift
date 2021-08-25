//
//  SupportPageViewController.swift
//  Leef
//
//  Created by J on 2021/08/24.
//

import UIKit
import SoftUIView


class SupportPageViewController: UIViewController {
    
    var color = MainColor()

     //Twitter連携
    var twitterButton = SoftUIView()
     //利用規約
    let tosButton = SoftUIView()
     //プライバシーポリシー
    let privacyPolicyButton = SoftUIView()
     //通報
     let reportButton = SoftUIView()
    //お問い合わせ
   let contactButton = SoftUIView()
    
    
    override func loadView() {
        super.loadView()
        configureLoginButton()
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
    }
    
    
    
    func configureLoginButton() {
        view.addSubview(twitterButton)
        twitterButton.mainColor = color.backColor.cgColor
        twitterButton.darkShadowColor = color.darkShadow.cgColor
        twitterButton.lightShadowColor = color.lightShadow.cgColor
        twitterButton.cornerRadius = 20
        
        //Button内にLabelを配置
        let label = UILabel()
        twitterButton.setContentView(label)
        label.text = "Twitter連携"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: twitterButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: twitterButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.blueColor
        twitterButton.addTarget(self, action: #selector(isLoginCheck), for: .touchUpInside)
        setTwitterButton()
    }
   
    func setTwitterButton() {
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twitterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func isLoginCheck() {
        print("isLoginCheck")
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
   
    func setTOSButton() {
        tosButton.translatesAutoresizingMaskIntoConstraints = false
        tosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tosButton.topAnchor.constraint(equalTo: twitterButton.bottomAnchor,  constant: 20).isActive = true
        tosButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        tosButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func toTOSPage() {
        print("toTOSPage")
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
   
    func setPrivacyPolicyButton() {
        privacyPolicyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyPolicyButton.topAnchor.constraint(equalTo: tosButton.bottomAnchor,  constant: 20).isActive = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func toPrivacyPolicyPage() {
        print("toPrivacyPolicyPage")
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
   
    func setReportButton() {
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        reportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reportButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor,  constant: 20).isActive = true
        reportButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        reportButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func toReportPage() {
        print("toReportPage")
    }
    
    //let contactButton = SoftUIView()
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
   
    func setContactButton() {
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contactButton.topAnchor.constraint(equalTo: reportButton.bottomAnchor,  constant: 20).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    
    @objc func toContactPage() {
        print("toContactPage")
    }
    
    
    
}
