//
//  ViewController.swift
//  Leef
//
//  Created by J on 2021/06/28.
//

import UIKit

class ViewController: UIViewController {
    
    var mainColor = MainColor()
    
    var username = String()
    
    let button: UIButton = {
        let view = UIButton()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return view
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = mainColor.whiteColor
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonTapped))
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true


}
    @objc func createButtonTapped() {
        print("createButtonTapped")
    }

    @objc func tap() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
