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
    
    // UI
    private var titleImageView = UIImageView()
    private var button = SoftUIView()
    private var animationView = AnimationView()
    
    private var color = MainColor()
    private var sendDBModel = SendDBModel()
    private var indicater = Indicater()
    private var softUI = ConfigureSoftUIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
        
        configureAnimation()
        configureTitleImageView()
        configurebutton()
    }
    
   private func configureTitleImageView() {
        view.addSubview(titleImageView)
        titleImageView.image = #imageLiteral(resourceName: "LeefTitleImage")
        titleImageView.contentMode = .scaleAspectFit
        setTitleImageView()
    }
    

    private func configureAnimation() {
        animationView = AnimationView(name: LottieAnimation().firstViewAnimation)
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        view.addSubview(animationView)
    }
    
    private func configurebutton() {
        view.addSubview(button)
        button.cornerRadius = 20
        softUI.setButtonColor(button: button)
        softUI.setButtonLabel(button: button, labelText: "はじめる", fontSize: 13, textColor: color.darkGrayColor) // Button内にLabelを配置
        button.addTarget(self, action: #selector(pushPage), for: .touchUpInside)
        setLoginButton()
    }
        
    
    private func setTitleImageView() {
        let topConstant = view.frame.size.height * 0.13
        titleImageView.translatesAutoresizingMaskIntoConstraints                                         = false
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        titleImageView.heightAnchor.constraint(equalToConstant: 120).isActive                            = true
        titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive     = true
    }
    
    private func setLoginButton() {
        button.translatesAutoresizingMaskIntoConstraints                                       = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive   = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    
    
    @objc
    private func pushPage() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    
}
