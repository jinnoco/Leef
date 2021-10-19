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
import Lottie
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    // UI
    private var topLabel = UILabel()
    private var imageView = UIImageView()
    private var twitterLoginButton = UIButton()
    private var appleLoginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    private var tosButton = SoftUIView() // tos = terms of service: 利用規約
    private var withoutRegisterButton = UIButton()
    private var toslabel = UILabel()
    private var consentLabel = UILabel()
    private var consentButton = UIButton()
    
    private var indicater = Indicater()
    private var color = MainColor()
    private var provider: OAuthProvider?
    private var twiiterLogin = TwittreLogin()
    private var appleLogin = AppleLogin()
    private var openURL = OpenURL()
    private var softUI = ConfigureSoftUIButton()
    private var webURL = URLs()
    private var baseUI = BaseUI()
    
    // 利用規約同意テェック判定
    private var checked = false
    
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
    
    
    private func configureLoginTextLabel() {
        view.addSubview(topLabel)
        setLoginTextLabel()
        topLabel.text = "ログインまたはユーザー登録"
        topLabel.textColor = color.darkGrayColor
        topLabel.font = UIFont(name: baseUI.textFont, size: 17)
    }
    
    
    private func configureImageView() {
        view.addSubview(imageView)
        setImageView()
        imageView.image = #imageLiteral(resourceName: "LeefAppIcon")
        imageView.contentMode = .scaleAspectFit
    }
    
    
    
    private func configureTOSButton() {
        view.addSubview(tosButton)
        setTOSButton()
        tosButton.cornerRadius = 20
        softUI.setButtonColor(button: tosButton)
        softUI.setButtonLabel(button: tosButton, labelText: "利用規約", fontSize: 13) // Button内にLabelを配置
        tosButton.addTarget(self, action: #selector(toTOSPage), for: .touchUpInside)
        
    }
    
    
    private func configureAppleLoginButton() {
        if #available(iOS 13.0, *) {
            view.addSubview(appleLoginButton)
            setAppleLoginButton()
            appleLoginButton.addTarget(self, action: #selector(appleLogin.handleTappedAppleLoginButton(_:)), for: .touchUpInside)
            appleLoginButton.cornerRadius = 20
        }
    }
    
    
    
    private func configureTwitterLoginButton() {
        view.addSubview(twitterLoginButton)
        setLoginButton()
        twitterLoginButton.layer.cornerRadius = 20
        twitterLoginButton.setTitle("Twitterでログイン", for: .normal)
        twitterLoginButton.titleLabel?.font = UIFont(name: baseUI.textFont, size: 13)
        twitterLoginButton.backgroundColor = color.darkGrayColor
        twitterLoginButton.tintColor = .white
        twitterLoginButton.addTarget(self, action: #selector(twiiterLogin.login), for: .touchUpInside)
    }
    
    
    private func configureConsentLabel() {
        view.addSubview(consentLabel)
        setConsentLabel()
        consentLabel.text = "利用規約に同意します"
        consentLabel.textColor = color.darkGrayColor
        consentLabel.font = UIFont(name: baseUI.textFont, size: 13)
    }
    
    
    private func configurecConsentButton() {
        view.addSubview(consentButton)
        setConsentButton()
        consentButton.setImage(UIImage(systemName: "square"), for: .normal)
        consentButton.tintColor = color.darkGrayColor
        consentButton.addTarget(self, action: #selector(tappedConsentButton), for: .touchUpInside)
    }
    
    
    private func configureWithOutRegisterButton() {
        view.addSubview(withoutRegisterButton)
        withoutRegisterButton.layer.cornerRadius = 20
        withoutRegisterButton.setTitle("ユーザー登録せずにはじめる", for: .normal)
        withoutRegisterButton.titleLabel?.font = UIFont(name: baseUI.textFont, size: 13)
        withoutRegisterButton.backgroundColor = color.darkGrayColor
        withoutRegisterButton.tintColor = .white
        withoutRegisterButton.addTarget(self, action: #selector(pushPage), for: .touchUpInside)
        setWithOutRegisterButton()
    }
    
    
    
    private func setLoginTextLabel() {
        topLabel.translatesAutoresizingMaskIntoConstraints                                = false
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive           = true
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive     = true
    }
    
    
    private func setImageView() {
        let height = view.frame.size.height / 5
        let width = height
        imageView.translatesAutoresizingMaskIntoConstraints                                             = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                        = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive        = true
        imageView.heightAnchor.constraint(equalToConstant: height).isActive                             = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive                               = true
    }
    
    
    private func setTOSButton() {
        tosButton.translatesAutoresizingMaskIntoConstraints                                          = false
        tosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
        tosButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70).isActive       = true
        tosButton.widthAnchor.constraint(equalToConstant: 250).isActive                              = true
        tosButton.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
    }
    
    
    private func setConsentButton() {
        consentButton.translatesAutoresizingMaskIntoConstraints                                                 = false
        consentButton.centerYAnchor.constraint(equalTo: consentLabel.centerYAnchor).isActive                    = true
        consentButton.leadingAnchor.constraint(equalTo: consentLabel.trailingAnchor, constant: 20).isActive     = true
    }
    
    
    private func setConsentLabel() {
        consentLabel.translatesAutoresizingMaskIntoConstraints                                      = false
        consentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                 = true
        consentLabel.topAnchor.constraint(equalTo: tosButton.bottomAnchor, constant: 20).isActive   = true
    }
    
    
    private func setAppleLoginButton() {
        appleLoginButton.translatesAutoresizingMaskIntoConstraints                                          = false
        appleLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
        appleLoginButton.topAnchor.constraint(equalTo: consentLabel.bottomAnchor, constant: 25).isActive    = true
        appleLoginButton.widthAnchor.constraint(equalToConstant: 250).isActive                              = true
        appleLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
    }
    
    
    
    private func setLoginButton() {
        twitterLoginButton.translatesAutoresizingMaskIntoConstraints                                            = false
        twitterLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                       = true
        twitterLoginButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 25).isActive  = true
        twitterLoginButton.widthAnchor.constraint(equalToConstant: 250).isActive                                = true
        twitterLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive                                = true
    }
    
    
    private func setWithOutRegisterButton() {
        withoutRegisterButton.translatesAutoresizingMaskIntoConstraints                                                 = false
        withoutRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                            = true
        withoutRegisterButton.topAnchor.constraint(equalTo: twitterLoginButton.bottomAnchor, constant: 25).isActive     = true
        withoutRegisterButton.widthAnchor.constraint(equalToConstant: 250).isActive                                     = true
        withoutRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive                                     = true
    }
    
    
    @objc
    private func tappedConsentButton() {
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
    private func twitterSignup() {
        // Twiiterアカウント作成ページに遷移
        openURL.toWebPage(url: webURL.twitterURL)
    }
    
    
    
    @objc
    private func toTOSPage() {
        let termsOfServiceViewController = TermsOfServiceViewController()
        present(termsOfServiceViewController, animated: true, completion: nil)
    }
    
    
    @objc
    private func pushPage() {
        let mainTabBarController = MainTabBarController()
        self.navigationController?.pushViewController(mainTabBarController, animated: true)
    }
    
    
}
