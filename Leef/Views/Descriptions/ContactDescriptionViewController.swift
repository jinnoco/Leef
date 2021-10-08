//
//  ContactDescriptionViewController.swift
//  Leef
//
//  Created by J on 2021/08/30.
//

import UIKit

class ContactDescriptionViewController: UIPageViewController {
    
    let tutorialImageView = UIImageView()
    var color = MainColor()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color.backColor
        configureTutorialImageView()
    }
    
    func configureTutorialImageView() {
        view.addSubview(tutorialImageView)
        tutorialImageView.contentMode = .scaleAspectFit
        tutorialImageView.image = #imageLiteral(resourceName: "Contact_Description")
        setTutorialImageView()
    }
    
    func setTutorialImageView() {
        tutorialImageView.translatesAutoresizingMaskIntoConstraints                                        = false
        tutorialImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive             = true
        tutorialImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive     = true
        tutorialImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive  = true
        tutorialImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive      = true
    }
    
}
