//
//  ModalViewController.swift
//  Leef
//
//  Created by J on 2021/10/05.
//

import UIKit
import SoftUIView
import Firebase
import NVActivityIndicatorView


class ModalViewController: UIViewController {
    
    let label = UILabel()
    let logoImageView = UIImageView()
    let loginButton = SoftUIView()
    let signupButton = SoftUIView()
    let cancelButton = SoftUIView()
    
    var color = MainColor()
    
    let indicater = Indicater()
    
    
    var provider: OAuthProvider?
    
    override func viewWillAppear(_ animated: Bool) {
        
        if #available(iOS 13.0, *) {
            presentingViewController?.beginAppearanceTransition(false, animated: animated)
        }
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 13.0, *) {
            
            presentingViewController?.beginAppearanceTransition(true, animated: animated)
            presentingViewController?.endAppearanceTransition()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 13.0, *) {
            presentingViewController?.endAppearanceTransition()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
        configureLabel()
        configureCancelButton()
        configureSignupButton()
        configureLoginButton()
        configureLogoImageView()
        
        indicater.configureIndicater(to: view)
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang": "ja"]
    }
    
    func configureLabel() {
        view.addSubview(label)
        setLabel()
        label.text = "Twitterアカウント連携"
        label.textColor = color.darkGrayColor
        label.font = UIFont(name: "AvenirNext-Bold", size: 17)
        
    }
    
    
    
    
    func configureCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.mainColor = color.backColor.cgColor
        cancelButton.darkShadowColor = color.darkShadow.cgColor
        cancelButton.lightShadowColor = color.lightShadow.cgColor
        cancelButton.cornerRadius = 20
        // Button内にLabelを配置
        let label = UILabel()
        cancelButton.setContentView(label)
        label.text = "キャンセル"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        setCancelButton()
    }
    
    func configureSignupButton() {
        view.addSubview(signupButton)
        signupButton.mainColor = color.backColor.cgColor
        signupButton.darkShadowColor = color.darkShadow.cgColor
        signupButton.lightShadowColor = color.lightShadow.cgColor
        signupButton.cornerRadius = 20
        // Button内にLabelを配置
        let label = UILabel()
        signupButton.setContentView(label)
        label.text = "アカウントを作成"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: signupButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: signupButton.centerYAnchor).isActive = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.darkGrayColor
        signupButton.addTarget(self, action: #selector(toSignupPage), for: .touchUpInside)
        setSignupButton()
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.mainColor = color.backColor.cgColor
        loginButton.darkShadowColor = color.darkShadow.cgColor
        loginButton.lightShadowColor = color.lightShadow.cgColor
        loginButton.cornerRadius = 20
        // Button内にLabelを配置
        let label = UILabel()
        loginButton.setContentView(label)
        label.text = "Twitterにログイン"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = color.blueColor
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        setLoginButton()
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        setLogoimageView()
        logoImageView.image = #imageLiteral(resourceName: "LeefAppIcon")
        logoImageView.contentMode = .scaleAspectFit
        
    }
    
    func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    func setSignupButton() {
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    func setLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -20).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    func setLogoimageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -100).isActive = true
    }
    
    @objc
    func login() {
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login": "true"]
        provider?.getCredentialWith(nil, completion: { [self] (credential, error) in
            
            if error != nil {
                print("ログイン処理エラー: \(error.debugDescription)")
                return
            }
            
            indicater.startIndicater()
            
            if let credential = credential {
                Auth.auth().signIn(with: credential) { (result, error) in
                    
                    if error != nil {
                        print("ログイン処理エラー: \(error.debugDescription)")
                        return
                    }
                    // @usernameを取得しUserDefaultsに保存
                    guard let userInfo = result?.additionalUserInfo?.profile else { return }
                    let userId = userInfo["screen_name"] as? String
                    print("result?.additionalUserInfo?.providerID -> Twitter @username: \(userId)")
                    UserDefaults.standard.setValue(userId, forKey: "userId")
                    
                    indicater.stopIndicater()
                    
                    dismiss(animated: true, completion: nil)
                    
                }
            }
            
        })
        
        
        
    }
    
    @objc
    func toSignupPage() {
        // Twiiterアカウント作成ページに遷移
        guard let url = NSURL(string: "https://twitter.com/?lang=ja") else { return }
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
