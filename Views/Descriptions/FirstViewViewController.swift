//
//  FirstViewController.swift
//  Leef
//
//  Created by J on 2021/06/28.
//

import UIKit
import SoftUIView
import Lottie

class FirstViewController: UIViewController {
    
    let color = MainColor()
    var sendDBModel = SendDBModel()
    let indicater = Indicater()
    
    //UI
    let titleImageView = UIImageView()
    let button = SoftUIView()
    var animationView = AnimationView()
    
//    
//    override func loadView() {
//        super.loadView()
//        
//        configureAnimation()
//        configureTitleImageView()
//        configurebutton()
//        indicater.configureIndicater(to: view)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
        
        configureAnimation()
        configureTitleImageView()
        configurebutton()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configureTitleImageView() {
        view.addSubview(titleImageView)
        titleImageView.image = UIImage(named: "LeefTitleImage")
        titleImageView.contentMode = .scaleAspectFit
        setTitleImageView()
    }
    
    
    
    private func configureAnimation() {
        
        animationView = AnimationView(name: "lf30_editor_mtdla6kp")
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
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
        let topConstant = view.frame.size.height * 0.13
        titleImageView.translatesAutoresizingMaskIntoConstraints                                        = false
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                   = true
        titleImageView.heightAnchor.constraint(equalToConstant: 120).isActive                        = true
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
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
        
    }
    
    
}



