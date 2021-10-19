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
    
    var openURL = OpenURL()
    
    private var baseUI = BaseUI()
    private var webURL = URLs()
    private var softUI = ConfigureSoftUIButton()
    
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
        softUI.setButtonColor(button: tosButton)
        tosButton.cornerRadius = 20
        softUI.setButtonLabel(button: tosButton, labelText: "利用規約") // Button内にLabelを配置
        tosButton.addTarget(self, action: #selector(toTOSPage), for: .touchUpInside)
        setTOSButton()
    }
    
    
 
    func configurePrivacyPolicyButton() {
        view.addSubview(privacyPolicyButton)
        softUI.setButtonColor(button: privacyPolicyButton)
        privacyPolicyButton.cornerRadius = 20
        softUI.setButtonLabel(button: privacyPolicyButton, labelText: "プライバシーポリシー") // Button内にLabelを配置
        privacyPolicyButton.addTarget(self, action: #selector(toPrivacyPolicyPage), for: .touchUpInside)
        setPrivacyPolicyButton()
    }
    
   
    
    func configureReportButton() {
        view.addSubview(reportButton)
        softUI.setButtonColor(button: reportButton)
        reportButton.cornerRadius = 20
        softUI.setButtonLabel(button: reportButton, labelText: "ユーザー通報") // Button内にLabelを配置
        reportButton.addTarget(self, action: #selector(toReportPage), for: .touchUpInside)
        setReportButton()
    }
    
    
    
    func configureContactButton() {
        view.addSubview(contactButton)
        softUI.setButtonColor(button: contactButton)
        contactButton.cornerRadius = 20
        softUI.setButtonLabel(button: contactButton, labelText: "お問い合わせ")
        contactButton.addTarget(self, action: #selector(toContactPage), for: .touchUpInside)
        setContactButton()
        
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
        openURL.toWebPage(url: webURL.tosPageURL)
    }
    
    // プライバシーポリシー
    @objc
    func toPrivacyPolicyPage() {
        openURL.toWebPage(url: webURL.privacyPolicyPageURL)
    }
    
    // ユーザー通報ページ
    @objc
    func toReportPage() {
        openURL.toWebPage(url: webURL.reportPageURL)
    }
    
    // Twitterアカウントに遷移
    @objc
    func toContactPage() {
        openURL.toWebPage(url: webURL.contactPageURL)
    }

    
    
}
