//
//  LoginViewController.swift
//  Leef
//
//  Created by J on 2021/06/28.
//

import UIKit
import SoftUIView
import Firebase
import AuthenticationServices
import CryptoKit
import Lottie
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    fileprivate var currentNonce: String?
    
    // UI
    let topLabel = UILabel()
    var imageView = UIImageView()
    let twitterLoginButton = UIButton()
    let appleLoginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    let tosButton = SoftUIView() // tos = terms of service: 利用規約
    let withoutRegisterButton = UIButton()
    let toslabel = UILabel()
    let consentLabel = UILabel()
    var consentButton = UIButton()
    
    let indicater = Indicater()
    var color = MainColor()
    var provider: OAuthProvider?
    let loadDBModel = LoadDBModel()
    
    var appleLogin = AppleLogin()
    var openURL: OpenURL!
    
    // 利用規約同意テェック判定
    var checked = false
    
    override func loadView() {
        super.loadView()
        
        configureLoginTextLabel()
        configureImageView()
        configureTOSButton()
        configureConsentLabel()
        configurecConsentButton()
        configureAppleLoginButton()
        configureTwitterLoginButton()
        configureWithOutRegisterButton()
        indicater.configureIndicater(to: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
        
        // buttonhは初期状態では押せないようにする
        appleLoginButton.isEnabled = false
        twitterLoginButton.isEnabled = false
        withoutRegisterButton.isEnabled = false
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang": "ja"]
        
    }
    
    
    func configureLoginTextLabel() {
        view.addSubview(topLabel)
        setLoginTextLabel()
        topLabel.text = "ログインまたはユーザー登録"
        topLabel.textColor = color.darkGrayColor
        topLabel.font = UIFont(name: "AvenirNext-Bold", size: 17)
    }
    
    
    func configureImageView() {
        view.addSubview(imageView)
        setImageView()
        imageView.image = #imageLiteral(resourceName: "LeefAppIcon")
        imageView.contentMode = .scaleAspectFit
    }
    
    
    
    func configureTOSButton() {
        view.addSubview(tosButton)
        setTOSButton()
        tosButton.mainColor = color.backColor.cgColor
        tosButton.darkShadowColor = color.darkShadow.cgColor
        tosButton.lightShadowColor = color.lightShadow.cgColor
        tosButton.cornerRadius = 20
        
        // Button内にLabelを配置
        let label = UILabel()
        tosButton.setContentView(label)
        label.text = "利用規約"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: tosButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: tosButton.centerYAnchor).isActive = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.darkGrayColor
        tosButton.addTarget(self, action: #selector(toTOSPage), for: .touchUpInside)
        
    }
    
    
    func configureAppleLoginButton() {
        if #available(iOS 13.0, *) {
            view.addSubview(appleLoginButton)
            setAppleLoginButton()
            appleLoginButton.addTarget(self, action: #selector(appleLogin.handleTappedAppleLoginButton(_:)), for: .touchUpInside)
            appleLoginButton.cornerRadius = 20
        }
    }
    
    
    
    func configureTwitterLoginButton() {
        view.addSubview(twitterLoginButton)
        setLoginButton()
        twitterLoginButton.layer.cornerRadius = 20
        twitterLoginButton.setTitle("Twitterでログイン", for: .normal)
        twitterLoginButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 13)
        twitterLoginButton.backgroundColor = color.darkGrayColor
        twitterLoginButton.tintColor = .white
        twitterLoginButton.addTarget(self, action: #selector(twitterLogin), for: .touchUpInside)
        
    }
    
    
    func configureConsentLabel() {
        view.addSubview(consentLabel)
        setConsentLabel()
        consentLabel.text = "利用規約に同意します"
        consentLabel.textColor = color.darkGrayColor
        consentLabel.font = UIFont(name: "AvenirNext-Bold", size: 13)
    }
    
    
    
    func configurecConsentButton() {
        view.addSubview(consentButton)
        setConsentButton()
        consentButton.setImage(UIImage(systemName: "square"), for: .normal)
        consentButton.tintColor = color.darkGrayColor
        consentButton.addTarget(self, action: #selector(tappedConsentButton), for: .touchUpInside)
        
    }
    
    
    func configureWithOutRegisterButton() {
        view.addSubview(withoutRegisterButton)
        withoutRegisterButton.layer.cornerRadius = 20
        withoutRegisterButton.setTitle("ユーザー登録せずにはじめる", for: .normal)
        withoutRegisterButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 13)
        withoutRegisterButton.backgroundColor = color.darkGrayColor
        withoutRegisterButton.tintColor = .white
        withoutRegisterButton.addTarget(self, action: #selector(pushPage), for: .touchUpInside)
        setWithOutRegisterButton()
    }
    
    
    
    func setLoginTextLabel() {
        topLabel.translatesAutoresizingMaskIntoConstraints                                = false
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive           = true
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive     = true
    }
    
    func setImageView() {
        let height = view.frame.size.height / 5
        let width = height
        imageView.translatesAutoresizingMaskIntoConstraints                                             = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                        = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive        = true
        imageView.heightAnchor.constraint(equalToConstant: height).isActive                             = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive                               = true
    }
    
    
    func setTOSButton() {
        tosButton.translatesAutoresizingMaskIntoConstraints                                          = false
        tosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
        tosButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70).isActive       = true
        tosButton.widthAnchor.constraint(equalToConstant: 250).isActive                              = true
        tosButton.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
    }
    
    func setConsentButton() {
        consentButton.translatesAutoresizingMaskIntoConstraints                                                 = false
        consentButton.centerYAnchor.constraint(equalTo: consentLabel.centerYAnchor).isActive                    = true
        consentButton.leadingAnchor.constraint(equalTo: consentLabel.trailingAnchor, constant: 20).isActive     = true
    }
    
    func setConsentLabel() {
        consentLabel.translatesAutoresizingMaskIntoConstraints                                      = false
        consentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                 = true
        consentLabel.topAnchor.constraint(equalTo: tosButton.bottomAnchor, constant: 20).isActive   = true
    }
    
    func setAppleLoginButton() {
        appleLoginButton.translatesAutoresizingMaskIntoConstraints                                          = false
        appleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
        appleLoginButton.topAnchor.constraint(equalTo: consentLabel.bottomAnchor, constant: 25).isActive    = true
        appleLoginButton.widthAnchor.constraint(equalToConstant: 250).isActive                              = true
        appleLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
    }
    
    
    
    func setLoginButton() {
        twitterLoginButton.translatesAutoresizingMaskIntoConstraints                                            = false
        twitterLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                       = true
        twitterLoginButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 25).isActive  = true
        twitterLoginButton.widthAnchor.constraint(equalToConstant: 250).isActive                                = true
        twitterLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive                                = true
    }
    
    
    func setWithOutRegisterButton() {
        withoutRegisterButton.translatesAutoresizingMaskIntoConstraints                                                 = false
        withoutRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                            = true
        withoutRegisterButton.topAnchor.constraint(equalTo: twitterLoginButton.bottomAnchor, constant: 25).isActive     = true
        withoutRegisterButton.widthAnchor.constraint(equalToConstant: 250).isActive                                     = true
        withoutRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive                                     = true
    }
    
    
    

    
    
    
    @objc
    func tappedConsentButton() {
        switch checked {
        
        case false:
            // テェック完了画像に変更
            consentButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            consentButton.tintColor = color.darkGrayColor
            
            // 各ボタンの背景色を変え押せるようにする
            appleLoginButton.isEnabled = true
            
            twitterLoginButton.isEnabled = true
            twitterLoginButton.backgroundColor = color.blueColor
            
            withoutRegisterButton.isEnabled = true
            withoutRegisterButton.backgroundColor = color.greenColor
            
            checked = true
            
        case true:
            // 未テェック画像に変更
            consentButton.setImage(UIImage(systemName: "square"), for: .normal)
            
            // 各ボタンの背景色を変え押せるようにする
            appleLoginButton.isEnabled = false
            
            twitterLoginButton.isEnabled = false
            twitterLoginButton.backgroundColor = color.darkGrayColor
            
            withoutRegisterButton.isEnabled = false
            withoutRegisterButton.backgroundColor = color.darkGrayColor
            
            checked = false
        }
    }
    
    
    @objc
    func twitterSignup() {
        // Twiiterアカウント作成ページに遷移
        openURL.toWebPage(url: "https://twitter.com/?lang=ja")
      
    }
    
    
    
    @objc
    func toTOSPage() {
        let termsOfServiceViewController = TermsOfServiceViewController()
        present(termsOfServiceViewController, animated: true, completion: nil)
    }
    
    
    @objc
    func pushPage() {
        let mainTabBarController = MainTabBarController()
        self.navigationController?.pushViewController(mainTabBarController, animated: true)
    }
    
    
    
    
    @objc
    func twitterLogin() {
        
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
                    if let userId = userInfo["screen_name"] as? String {
                        print("result?.additionalUserInfo?.providerID -> Twitter @username: \(userId)")
                        UserDefaults.standard.setValue(userId, forKey: "userId")
                    }
                    
                    
                    indicater.stopIndicater()
                    
                    let mainTabBarController = MainTabBarController()
                    navigationController?.pushViewController(mainTabBarController, animated: true)
                    
                }
            }
        })
    }
    
    
    
}

