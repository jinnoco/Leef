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
    
   
    
    // UI
    private var animationView = AnimationView()
    private var tosButton = SoftUIView() // 利用規約
    private var privacyPolicyButton = SoftUIView() // プライバシーポリシー
    private var reportButton = SoftUIView() // 通報ページ
    private var contactButton = SoftUIView() // お問い合わせ
    
    private var openURL = OpenURL()
    private var color = MainColor()
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
    
    
    private func configureAnimation() {
        animationView = AnimationView(name: "41384-customer-support-animation")
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        setAnimationView()
    }
    
    
    private func configureTOSButton() {
        view.addSubview(tosButton)
        softUI.setButtonColor(button: tosButton)
        tosButton.cornerRadius = 20
        softUI.setButtonLabel(button: tosButton, labelText: "利用規約", fontSize: 14, textColor: color.darkGrayColor) // Button内にLabelを配置
        tosButton.addTarget(self, action: #selector(toTOSPage), for: .touchUpInside)
        setTOSButton()
    }
    
    
    
    private func configurePrivacyPolicyButton() {
        view.addSubview(privacyPolicyButton)
        softUI.setButtonColor(button: privacyPolicyButton)
        privacyPolicyButton.cornerRadius = 20
        softUI.setButtonLabel(button: privacyPolicyButton, labelText: "プライバシーポリシー", fontSize: 14, textColor: color.darkGrayColor) // Button内にLabelを配置
        privacyPolicyButton.addTarget(self, action: #selector(toPrivacyPolicyPage), for: .touchUpInside)
        setPrivacyPolicyButton()
    }
    
    
    
    private func configureReportButton() {
        view.addSubview(reportButton)
        softUI.setButtonColor(button: reportButton)
        reportButton.cornerRadius = 20
        softUI.setButtonLabel(button: reportButton, labelText: "ユーザー通報", fontSize: 14, textColor: color.darkGrayColor) // Button内にLabelを配置
        reportButton.addTarget(self, action: #selector(toReportPage), for: .touchUpInside)
        setReportButton()
    }
    
    
    
    private func configureContactButton() {
        view.addSubview(contactButton)
        softUI.setButtonColor(button: contactButton)
        contactButton.cornerRadius = 20
        softUI.setButtonLabel(button: contactButton, labelText: "お問い合わせ", fontSize: 14, textColor: color.darkGrayColor)
        contactButton.addTarget(self, action: #selector(toContactPage), for: .touchUpInside)
        setContactButton()
        
    }
    
    
    private func setAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        let width = view.frame.size.width / 2
        let height = view.frame.size.height / 3
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive        = true
        animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive  = true
        animationView.widthAnchor.constraint(equalToConstant: width).isActive               = true
        animationView.heightAnchor.constraint(equalToConstant: height).isActive             = true
        
    }
    
    private func setTOSButton() {
        tosButton.translatesAutoresizingMaskIntoConstraints                                         = false
        tosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        tosButton.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20).isActive  = true
        tosButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        tosButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    private func setPrivacyPolicyButton() {
        privacyPolicyButton.translatesAutoresizingMaskIntoConstraints                                       = false
        privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        privacyPolicyButton.topAnchor.constraint(equalTo: tosButton.bottomAnchor, constant: 20).isActive    = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    
    private func setReportButton() {
        reportButton.translatesAutoresizingMaskIntoConstraints                                                  = false
        reportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                             = true
        reportButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor, constant: 20).isActive     = true
        reportButton.widthAnchor.constraint(equalToConstant: 250).isActive                                      = true
        reportButton.heightAnchor.constraint(equalToConstant: 40).isActive                                      = true
    }
    
    private func setContactButton() {
        contactButton.translatesAutoresizingMaskIntoConstraints                                         = false
        contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        contactButton.topAnchor.constraint(equalTo: reportButton.bottomAnchor, constant: 20).isActive   = true
        contactButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        contactButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    
    
    // 外部ブラウザに画面遷移
    @objc
    private func toTOSPage() {
        openURL.toWebPage(url: webURL.tosPageURL)
    }
    
    // プライバシーポリシー
    @objc
    private func toPrivacyPolicyPage() {
        openURL.toWebPage(url: webURL.privacyPolicyPageURL)
    }
    
    // ユーザー通報ページ
    @objc
    private func toReportPage() {
        openURL.toWebPage(url: webURL.reportPageURL)
    }
    
    // Twitterアカウントに遷移
    @objc
    private func toContactPage() {
        openURL.toWebPage(url: webURL.contactPageURL)
    }
    
    
    
}
