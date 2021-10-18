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
    
    // UI
    var animationView = AnimationView()
    let tosButton = SoftUIView() // 利用規約
    let privacyPolicyButton = SoftUIView() // プライバシーポリシー
    let reportButton = SoftUIView() // 通報ページ
    let contactButton = SoftUIView() // お問い合わせ
    
    
    
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
        super.viewWillAppear(animated)
        
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
        setButtonColor(button: tosButton)
        tosButton.cornerRadius = 20
        setButtonLabel(button: tosButton, labelText: "利用規約") // Button内にLabelを配置
        tosButton.addTarget(self, action: #selector(toTOSPage), for: .touchUpInside)
        setTOSButton()
    }
    
    
 
    func configurePrivacyPolicyButton() {
        view.addSubview(privacyPolicyButton)
        setButtonColor(button: privacyPolicyButton)
        privacyPolicyButton.cornerRadius = 20
        setButtonLabel(button: privacyPolicyButton, labelText: "プライバシーポリシー") // Button内にLabelを配置
        privacyPolicyButton.addTarget(self, action: #selector(toPrivacyPolicyPage), for: .touchUpInside)
        setPrivacyPolicyButton()
    }
    
   
    
    func configureReportButton() {
        view.addSubview(reportButton)
        setButtonColor(button: reportButton)
        reportButton.cornerRadius = 20
        setButtonLabel(button: reportButton, labelText: "ユーザー通報") // Button内にLabelを配置
        reportButton.addTarget(self, action: #selector(toReportPage), for: .touchUpInside)
        setReportButton()
    }
    
    
    
    func configureContactButton() {
        view.addSubview(contactButton)
        setButtonColor(button: contactButton)
        contactButton.cornerRadius = 20
        setButtonLabel(button: contactButton, labelText: "お問い合わせ")  // Button内にLabelを配置
        contactButton.addTarget(self, action: #selector(toContactPage), for: .touchUpInside)
        setContactButton()
        
    }
    
    func setButtonColor(button: SoftUIView) {
        button.mainColor = color.backColor.cgColor
        button.darkShadowColor = color.darkShadow.cgColor
        button.lightShadowColor = color.lightShadow.cgColor
    }
    
    func setButtonLabel(button: SoftUIView, labelText: String) {
        let label = UILabel()
        label.text = labelText
        button.setContentView(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
    }
    
    
    func setAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
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
        privacyPolicyButton.topAnchor.constraint(equalTo: tosButton.bottomAnchor, constant: 20).isActive    = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    
    func setReportButton() {
        reportButton.translatesAutoresizingMaskIntoConstraints                                                  = false
        reportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                             = true
        reportButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor, constant: 20).isActive     = true
        reportButton.widthAnchor.constraint(equalToConstant: 250).isActive                                      = true
        reportButton.heightAnchor.constraint(equalToConstant: 40).isActive                                      = true
    }
    
    func setContactButton() {
        contactButton.translatesAutoresizingMaskIntoConstraints                                         = false
        contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        contactButton.topAnchor.constraint(equalTo: reportButton.bottomAnchor, constant: 20).isActive   = true
        contactButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        contactButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    
    
    // 外部ブラウザに画面遷移
    @objc
    func toTOSPage() {
        guard let url = NSURL(string: "https://site-2671642-9203-8355.mystrikingly.com") else { return }
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc
    func toPrivacyPolicyPage() {
        guard let url = NSURL(string: "https://site-2671642-386-3077.mystrikingly.com") else { return }
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc
    func toReportPage() {
        guard let url = NSURL(string: "https://site-2671642-9832-2847.mystrikingly.com") else { return }
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    // Twitterアカウントに遷移
    @objc
    func toContactPage() {
        guard let url = NSURL(string: "https://twitter.com/LeefApp_") else { return }
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    
}
