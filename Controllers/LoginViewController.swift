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
    let button = SoftUIView()
    var animationView = AnimationView()
    var activityIndicaterView: NVActivityIndicatorView!
    
    
    override func loadView() {
        super.loadView()
        
        configureAnimation()
        configureTitleImageView()
        configurebutton()
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
    

    
    func configureAnimation() {
        
        animationView = AnimationView(name: "lf30_editor_mtdla6kp")
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    func configurebutton() {
        view.addSubview(button)
        button.mainColor = color.backColor.cgColor
        button.darkShadowColor = color.darkShadow.cgColor
        button.lightShadowColor = color.lightShadow.cgColor
        button.cornerRadius = 20
        
        //Button内にLabelを配置
        let label = UILabel()
        button.setContentView(label)
        label.text = "はじめる"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.darkGrayColor
        button.addTarget(self, action: #selector(pushPage), for: .touchUpInside)
        setLoginButton()
    }
    

    
    func setTitleImageView() {
        let height = view.frame.size.height * 0.07
        let topConstant = view.frame.size.height * 0.2
        titleImageView.translatesAutoresizingMaskIntoConstraints                                        = false
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                   = true
        titleImageView.heightAnchor.constraint(equalToConstant: height).isActive                        = true
        titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:topConstant).isActive     = true
    }
    
    func  setLoginButton() {
        button.translatesAutoresizingMaskIntoConstraints                                       = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive   = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    

    

    
    @objc func pushPage() {
        //画面遷移
        let mainTabVC = MainTabBarController()
        navigationController?.pushViewController(mainTabVC, animated: true)
        
    }
    

}



