//
//  SelectViewController.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit
import Firebase

class SelectViewController: UIViewController {
    
    let db = Firestore.firestore()

    var color = MainColor()
    
    var username = UILabel()
    var profileImage = UIImageView()
    var image = UIImageView()
    var text = UITextView()
    var twitterButton = UIButton()
    var shareButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        print("viewHeight: ", height)
        print("viewWidth: ", width)
        
        print("shareButtonHeigth", shareButton.frame.size.height)
        

        view.backgroundColor = color.whiteColor
        
        
        configureShareButton()
        configureTwitterButton()
        configureText()
        configureImage()
        configureProfileImage()
        configureUsename()
        
        
        
       
    }
    
    func configureProfileImage() {
        view.addSubview(profileImage)
        setupPrfileImage()
        profileImage.layer.cornerRadius = 22
        profileImage.backgroundColor = color.blueColor
    }
    
    func setupPrfileImage() {
        let posTop = view.frame.size.height * 0.02
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -posTop).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    
    func configureUsename() {
        view.addSubview(username)
        setupUsername()
        username.text = "username"
    }
    
    func setupUsername() {
        username.translatesAutoresizingMaskIntoConstraints = false
        username.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20).isActive = true
    }
    
    func configureImage() {
        view.addSubview(image)
        image.backgroundColor = color.blueColor
        image.layer.cornerRadius = 10
        setupImage()
    }
    
    func setupImage() {

        let imageHeight = view.frame.size.height * 0.25
        let imageWidth = imageHeight * (4/3)
        let constant =  view.frame.size.height * 0.04
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: text.topAnchor, constant: -constant).isActive = true
        image.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        image.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
    }
    
    func configureText() {
        view.addSubview(text)
        setupText()
        text.text = "サンプル文字列"
        text.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        text.backgroundColor = color.lightGrayColor
    }
    
    func setupText() {
        text.translatesAutoresizingMaskIntoConstraints = false
        text.widthAnchor.constraint(equalTo:twitterButton.widthAnchor).isActive = true
        text.heightAnchor.constraint(equalToConstant: 100).isActive = true
        text.bottomAnchor.constraint(equalTo: twitterButton.topAnchor, constant: -40).isActive = true
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    func configureTwitterButton() {
        view.addSubview(twitterButton)
        setupTwitterButton()
        twitterButton.backgroundColor = color.blueColor
        let buttonHeght = view.frame.size.height * 0.05
        twitterButton.layer.cornerRadius = buttonHeght / 2
        twitterButton.setTitle("問い合わせる", for: .normal)
    }
    
    func setupTwitterButton() {
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twitterButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -30).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive = true
    }
    
    func configureShareButton() {
        view.addSubview(shareButton)
        setupShareButton()
        let buttonHeght = view.frame.size.height * 0.05
        shareButton.layer.cornerRadius = buttonHeght / 2
        shareButton.layer.borderColor = color.darkGrayColor.cgColor
        shareButton.layer.borderWidth = 1
        shareButton.setTitle("シェアする", for: .normal)
        shareButton.setTitleColor(color.darkGrayColor, for: .normal)
    }
    
    func setupShareButton() {
        let posBottom = view.frame.size.height * 0.15
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -posBottom).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive = true
        
    }
    
}
