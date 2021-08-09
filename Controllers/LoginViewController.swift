//
//  LoginViewController.swift
//  Leef
//
//  Created by J on 2021/06/28.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView
import SoftUIView
import Lottie

class LoginViewController: UIViewController {
    
    let color = MainColor()
    var provider: OAuthProvider?
    var sendDBModel = SendDBModel()
    let indicater = Indicater()
    
    //UI
    let titleImageView = UIImageView()
    let loginButton = SoftUIView()
    let signupButton = SoftUIView()
    var animationView = AnimationView()
    var activityIndicaterView: NVActivityIndicatorView!
    
    
    
    override func loadView() {
        super.loadView()
        
        configureAnimation()
        configureTitleImageView()
        configureLoginButton()
        configureSignupButton()
        indicater.configureIndicater(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = color.backColor
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang":"ja"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play()
    }
    
    func configureTitleImageView() {
        view.addSubview(titleImageView)
        setTitleImageView()
        titleImageView.image = UIImage(named: "LeefApp_title")
        titleImageView.contentMode = .scaleAspectFit
    }
    
    func setTitleImageView() {
        let height = view.frame.size.height * 0.07
        let topConstant = view.frame.size.height * 0.2
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:topConstant).isActive = true
    }
    
    func configureAnimation() {
        
        animationView = AnimationView(name: "lf30_editor_mtdla6kp")
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.mainColor = color.backColor.cgColor
        loginButton.darkShadowColor = color.darkShadow.cgColor
        loginButton.lightShadowColor = color.lightShadow.cgColor
        loginButton.cornerRadius = 20
        
        //Button内にLabelを配置
        let label = UILabel()
        loginButton.setContentView(label)
        label.text = "Twitterでログイン"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.blueColor
        loginButton.addTarget(self, action: #selector(twitterLogin), for: .touchUpInside)
        setLoginButton()
    }
    
    func configureSignupButton() {
        view.addSubview(signupButton)
        signupButton.mainColor = color.backColor.cgColor
        signupButton.darkShadowColor = color.darkShadow.cgColor
        signupButton.lightShadowColor = color.lightShadow.cgColor
        signupButton.cornerRadius = 20
        
        //Button内にLabelを配置
        let label = UILabel()
        signupButton.setContentView(label)
        label.text = "アカウントを作成"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: signupButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: signupButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.darkGrayColor
        signupButton.addTarget(self, action: #selector(twitterSignup), for: .touchUpInside)
        setSignupButton()
    }
    
    
    
    func  setLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints                                       = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive   = true
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    

    
    
    func setSignupButton() {
        signupButton.translatesAutoresizingMaskIntoConstraints                                              = false
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                         = true
        signupButton.centerYAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 45).isActive     = true
        signupButton.widthAnchor.constraint(equalToConstant: 250).isActive                                  = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive                                  = true
    }
    
    
    @objc func twitterLogin() {
        
        //ログイン処理
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: { [self] (credential, error) in
            
            if error != nil {
                print("ログイン処理エラー: \(error.debugDescription)")
                return
            }
            
            indicater.startIndicater()
            
            if credential != nil {
                Auth.auth().signIn(with: credential!) { (result, error) in
                    if error != nil {
                        print("ログイン処理エラー: \(error.debugDescription)")
                        return
                    }
                    //@usernameを取得しUserDefaultsに保存
                    print("result?.additionalUserInfo?.providerID -> Twitter @username: \(result?.additionalUserInfo?.profile!["screen_name"])")
                    let userId = result?.additionalUserInfo?.profile!["screen_name"] as! String
                    UserDefaults.standard.setValue(userId, forKey: "userId")
                    
                    indicater.stopIndicater()
                    
                    //画面遷移
                    let mainTabVC = MainTabBarController()
                    navigationController?.pushViewController(mainTabVC, animated: true)
                }
            }
        })
    }
    
   @objc func twitterSignup() {
        //Twiiterアカウント作成ページに遷移
        let url = NSURL(string: "https://twitter.com/?lang=ja")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    
    
}



