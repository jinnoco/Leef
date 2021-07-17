//
//  LoginViewController.swift
//  Leef
//
//  Created by J on 2021/06/28.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView
import WebKit

class LoginViewController: UIViewController {
    
    var color = MainColor()
    var provider: OAuthProvider?
    
    var sendDBModel = SendDBModel()

    let loginButton = UIButton()
    let signupButton = UIButton()
    
    var activityIndicaterView: NVActivityIndicatorView!
    
    var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loginViewController")
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = color.whiteColor
        
        configureLoginButton()
        configureSignupButton()
        configureIndicater()
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang":"ja"]

       
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.backgroundColor = color.blueColor
        loginButton.layer.cornerRadius = 20
        loginButton.setTitle("Twitterでログイン", for: .normal)
        loginButton.addTarget(self, action: #selector(twitterLogin), for: .touchUpInside)
        setupLoginButton()
    }

    func  setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureSignupButton() {
        view.addSubview(signupButton)
        signupButton.setTitle("アカウントを作成", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.addTarget(self, action: #selector(twitterSignup), for: .touchUpInside)
        setupSignupButton()
    }
    
    
    func setupSignupButton() {
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.centerYAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
    }
    
    
    @objc func twitterLogin() {
        /*
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: { [self] (credential, error) in
            
            if error != nil {
                return
            }
            
            //ActivityIndicatorView
            startIndicater()
            
            //ログイン処理
            if credential != nil {
                
                Auth.auth().signIn(with: credential!) { (result, error) in
                    
                    if error != nil {
                        print("error: ", error as Any)
                        return
                    }
                    
                    stopIndicater()
                    
                    print("tapped!!")
                    
                    let user = Auth.auth().currentUser
                    
                    if let user = user {
                        let imageURL = user.photoURL
                        let urlString = imageURL?.absoluteString
                        
                        //                    sendDBModel.sendProfileImageData(url: urlString!)
                        print("urlString: \(urlString)")
                        print("imageURL: \(imageURL)")
                        
                        sendDBModel.sendProfileImageData(url: urlString!)
                        
                        //   UserDefaults.standard.setValue(image, forKey: "userImage")
                        //     print("image type: ", type(of: image))
                    }
                    */
                    
                    //画面遷移
                    let timelineViewController = TimelineViewController()
                    navigationController?.pushViewController(timelineViewController, animated: true)
//
//                }
//            }
//
//
//        })

        
        
        
    }
    
    
    
    
    @objc func twitterSignup() {
       print("sign up!!")
    }
    
    
    func configureIndicater() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicaterView = NVActivityIndicatorView(frame: frame, type: .ballRotateChase, color: .lightGray, padding: .none)
        activityIndicaterView.center = self.view.center
        view.addSubview(activityIndicaterView)
    }

    func startIndicater() {
        activityIndicaterView.startAnimating()
    }
    
    func stopIndicater() {
        activityIndicaterView.stopAnimating()
    }
    
}
