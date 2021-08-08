//
//  SelectViewController.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit
import Firebase
import SoftUIView
import ImageViewer_swift

class SelectViewController: UIViewController {
    
    let db = Firestore.firestore()
    var color = MainColor()
    var userId = String()
    
    //UI
    var username = UILabel()
    var profileImageView = UIImageView()
    var profileImageString = String()
    var imageView = UIImageView()
    var postImageString = String()
    var textView = UITextView()
    var twitterButton = SoftUIView()
    var shareButton = SoftUIView()
   
    
    override func loadView() {
        super.loadView()
        
        configureShareButton()
        configureTwitterButton()
        configureTextView()
        configureImageView()
        configureProfileImage()
        configureUsename()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
  }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBarsOnSwipe = false //スワイプで非表示を無効
    }
    
    func configureProfileImage() {
        view.addSubview(profileImageView)
        setProfileImage()
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 22
        profileImageView.backgroundColor = color.blueColor
        profileImageView.loadImage(with: profileImageString)
    }

    func configureUsename() {
        view.addSubview(username)
        setUsername()
        username.font = UIFont(name: "AvenirNext-Bold", size: 18)
        username.textColor = color.darkGrayColor
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        setImageView()
        imageView.loadImage(with: postImageString)
        imageView.contentMode = .scaleAspectFit
        imageView.setupImageViewer()
    }
    
    func configureTextView() {
        view.addSubview(textView)
        setTextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 15
        textView.textColor = color.darkGrayColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.backgroundColor = color.whiteColor
    }

    func configureTwitterButton() {
        view.addSubview(twitterButton)
        setTwitterButton()
        let buttonHeght = view.frame.size.height * 0.05
        twitterButton.cornerRadius = buttonHeght / 2
        twitterButton.mainColor = color.backColor.cgColor
        twitterButton.darkShadowColor = color.darkShadow.cgColor
        twitterButton.lightShadowColor = color.lightShadow.cgColor
        twitterButton.addTarget(self, action: #selector(toTwitterWebPage), for: .touchUpInside)
        
        //Button内にLabelを配置
        let label = UILabel()
        twitterButton.setContentView(label)
        label.text = "問い合わせる"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: twitterButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: twitterButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.blueColor
    }
    
    func configureShareButton() {
      
        view.addSubview(shareButton)
        setShareButton()
        shareButton.clipsToBounds = false
        let buttonHeght = view.frame.size.height * 0.05
        shareButton.cornerRadius = buttonHeght / 2
        shareButton.mainColor = color.backColor.cgColor
        shareButton.darkShadowColor = color.darkShadow.cgColor
        shareButton.lightShadowColor = color.lightShadow.cgColor
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)

        //Button内にLabelを配置
        let label = UILabel()
        shareButton.setContentView(label)
        label.text = "シェアする"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor).isActive =  true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.darkGrayColor
    }
    
    func setProfileImage() {
        profileImageView.translatesAutoresizingMaskIntoConstraints                                      = false
        profileImageView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive  = true
        profileImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive            = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive                           = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive                          = true
    }




    func setUsername() {
        username.translatesAutoresizingMaskIntoConstraints                                                  = false
        username.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive                 = true
        username.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive  = true
    }

 

    func setImageView() {

        let imageHeight = view.frame.size.height * 0.25
        let imageWidth = imageHeight * (4/3)
        let constant = view.frame.size.height * 0.04
        imageView.translatesAutoresizingMaskIntoConstraints                                            = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                       = true
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -constant).isActive   = true
        imageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive                         = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive                       = true
    }


    func setTextView() {
        textView.translatesAutoresizingMaskIntoConstraints                                          = false
        textView.widthAnchor.constraint(equalTo:twitterButton.widthAnchor).isActive                 = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive                             = true
        textView.bottomAnchor.constraint(equalTo: twitterButton.topAnchor, constant: -30).isActive  = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
    }



  

    func setTwitterButton() {
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        twitterButton.translatesAutoresizingMaskIntoConstraints                                         = false
        twitterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        twitterButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -25).isActive   = true
        twitterButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive                     = true
        twitterButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive                    = true
    }



    func setShareButton() {
        let bottomConstant = view.frame.size.height * 0.20
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        shareButton.translatesAutoresizingMaskIntoConstraints                                           = false
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                      = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomConstant).isActive  = true
        shareButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive                       = true
        shareButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive                      = true

    }
    
    @objc func toTwitterWebPage() {
        // 外部ブラウザまたはTwitterアプリで投稿者のページを開く
        let userId = userId
        let url = NSURL(string: "https://twitter.com/\(userId)")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    
    
    }
    
    @objc func share() {
        //ActivityViewControllerを表示しSNSにシェア
        let postImage = imageView.image
        let postText = textView.text
        let activityItems = [postImage as Any, postText as Any] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
}
