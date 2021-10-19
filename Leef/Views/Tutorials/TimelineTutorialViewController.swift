//
//  TimelineTutorialViewController.swift
//  Leef
//
//  Created by J on 2021/08/26.
//

import UIKit

class TimelineTutorialViewController: UIViewController {
    
    private var tutorialImageView = UIImageView()
    private var color = MainColor()
    
    private var closeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
        configureCloseButton()
        configureTutorialImageView()
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        closeButton.setTitle("✖️", for: .normal)
        closeButton.tintColor = color.darkGrayColor
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        setCloseButton()
    }
    
    private func setCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    @objc
    private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureTutorialImageView() {
        view.addSubview(tutorialImageView)
        tutorialImageView.contentMode = .scaleAspectFit
        tutorialImageView.image = #imageLiteral(resourceName: "TimelineTutorial")
        setTutorialImageView()
    }
    
    private func setTutorialImageView() {
        tutorialImageView.translatesAutoresizingMaskIntoConstraints                                         = false
        tutorialImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive              = true
        tutorialImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive      = true
        tutorialImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive   = true
        tutorialImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive       = true
    }
    
    
    
}
