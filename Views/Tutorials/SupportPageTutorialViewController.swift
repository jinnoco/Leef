//
//  SupportPageTutorialViewController.swift
//  Leef
//
//  Created by J on 2021/08/26.
//

import UIKit
import  SoftUIView

class SupportPageTutorialViewController: UIViewController {
    
    let tutorialImageView = UIImageView()
    let button = SoftUIView()
    var color = MainColor()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color.backColor
        configureTutorialImageView()
//        configurebutton()
    }
    
    func configureTutorialImageView() {
        view.addSubview(tutorialImageView)
        tutorialImageView.contentMode = .scaleAspectFit
        tutorialImageView.image = UIImage(named: "SupportPageTutorial")
        setTutorialImageView()
    }
    
    func setTutorialImageView() {
        tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
        tutorialImageView.topAnchor.constraint(equalTo: view.topAnchor,  constant: 10).isActive = true
        tutorialImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tutorialImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tutorialImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
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
        button.addTarget(self, action: #selector(closeTutorial), for: .touchUpInside)
        setButton()
    }
    func setButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        button.topAnchor.constraint(equalTo: tutorialImageView.bottomAnchor).isActive   = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive                           = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive                           = true
    }
    
    @objc func closeTutorial() {
        dismiss(animated: true, completion: nil)
    }
    
}
