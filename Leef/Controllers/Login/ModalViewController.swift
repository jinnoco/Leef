//
//  ModalViewController.swift
//  Leef
//
//  Created by J on 2021/10/05.
//

import UIKit
import SoftUIView
import Firebase


class ModalViewController: UIViewController, loginDelegate {
    
    // UI
    private var label = UILabel()
    private var logoImageView = UIImageView()
    private var loginButton = SoftUIView()
    private var signupButton = SoftUIView()
    private var cancelButton = SoftUIView()
    
    private var color = MainColor()
    public var indicater = Indicater()
    var twitterLogin = TwitterLogin()
    private var baseUI = BaseUI()
    private var softUI = ConfigureSoftUIButton()
    private var webURL = URLs()
    private var openURL = OpenURL()
    private var provider: OAuthProvider?
    
    
    // PresentModal遷移後にもviewWillAppearを適用させる処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        twitterLogin.loginDelegate = self
        
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
    
    private func configureLabel() {
        view.addSubview(label)
        setLabel()
        label.text = "Twitterアカウント連携"
        label.textColor = color.darkGrayColor
        label.font = baseUI.defaultFont(fontSise: 17)
    }
    
    
    private func configureCancelButton() {
        view.addSubview(cancelButton)
        softUI.setButtonColor(button: cancelButton)
        cancelButton.cornerRadius = 20
        softUI.setButtonLabel(button: cancelButton, labelText: "キャンセル", fontSize: 14, textColor: color.darkGrayColor) // Button内にLabelを配置
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        setCancelButton()
    }
    
    private func configureSignupButton() {
        view.addSubview(signupButton)
        softUI.setButtonColor(button: signupButton)
        signupButton.cornerRadius = 20
        softUI.setButtonLabel(button: signupButton, labelText: "アカウントを作成", fontSize: 14, textColor: color.darkGrayColor) // Button内にLabelを配置
        signupButton.addTarget(self, action: #selector(toSignupPage), for: .touchUpInside)
        setSignupButton()
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        softUI.setButtonColor(button: loginButton)
        loginButton.cornerRadius = 20
        softUI.setButtonLabel(button: loginButton, labelText: "Twitterにログイン", fontSize: 14, textColor: color.blueColor) // Button内にLabelを配置
        loginButton.addTarget(twitterLogin, action: #selector(twitterLogin.login), for: .touchUpInside)
        setLoginButton()
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        setLogoimageView()
        logoImageView.image = #imageLiteral(resourceName: "LeefAppIcon")
        logoImageView.contentMode = .scaleAspectFit
        
    }
    
    private func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    private func setSignupButton() {
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    private func setLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -20).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive                             = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    private func setLogoimageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -100).isActive = true
    }
    
    func checkLogin(check: Int) {
        if check == 1 {
            indicater.startIndicater()
        } else if check == 2 {
            indicater.stopIndicater()
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    @objc
    private func toSignupPage() {
        // Twiiterアカウント作成ページに遷移
        openURL.toWebPage(url: webURL.twitterURL)
    }
    
    @objc
    private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
