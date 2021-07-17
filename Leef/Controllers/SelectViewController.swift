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

        view.backgroundColor = color.whiteColor
        configureImage()
        configureProfileImage()
        configureUsename()
        configureText()
        configureTwitterButton()
        configureShareButton()
    }
    
    func configureProfileImage() {
        view.addSubview(profileImage)
        setupPrfileImage()
        profileImage.layer.cornerRadius = 22
        profileImage.backgroundColor = color.blueColor
    }
    
    func setupPrfileImage() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
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
    
    func configureText() {
        view.addSubview(text)
        setupText()
        text.text = "サンプル文字列"
        text.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        text.backgroundColor = color.lightGrayColor
    }
    
    func setupText() {
        text.translatesAutoresizingMaskIntoConstraints = false
        text.widthAnchor.constraint(equalTo:image.widthAnchor).isActive = true
        text.heightAnchor.constraint(equalToConstant: 100).isActive = true
        text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40).isActive = true
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func configureImage() {
        view.addSubview(image)
        image.backgroundColor = color.blueColor
        image.layer.cornerRadius = 10
        setupImage()
    }
    
    func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: view.topAnchor, constant: 210).isActive = true
        image.widthAnchor.constraint(equalToConstant: 256).isActive = true
        image.heightAnchor.constraint(equalToConstant: 192).isActive = true
    }
    
    func configureTwitterButton() {
        view.addSubview(twitterButton)
        setupTwitterButton()
        twitterButton.backgroundColor = color.blueColor
        twitterButton.layer.cornerRadius = 20
        twitterButton.setTitle("問い合わせる", for: .normal)
    }
    
    func setupTwitterButton() {
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twitterButton.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 50).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureShareButton() {
        view.addSubview(shareButton)
        setupShareButton()
        shareButton.layer.cornerRadius = 20
        shareButton.layer.borderColor = color.darkGrayColor.cgColor
        shareButton.layer.borderWidth = 1
//        shareButton.backgroundColor = color.blueColor
        shareButton.setTitle("シェアする", for: .normal)
        shareButton.setTitleColor(color.darkGrayColor, for: .normal)
    }
    
    func setupShareButton() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: twitterButton.bottomAnchor, constant: 40).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
}
