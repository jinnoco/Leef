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
    
    
    var doc = String()
   
    
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
        username.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedUsername))
        username.addGestureRecognizer(tap)
        
        
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        setImageView()
        imageView.loadImage(with: postImageString)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
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
        textView.font = UIFont(name: "Helvetica", size: 15)
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
    
    @objc func tappedUsername() {
        
        let alertController = UIAlertController(title: "不適切なコンテンツですか？", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ユーザー通報ページへ", style: .destructive, handler: { actiom in
            self.toReportPage()
        }))
        alertController.addAction(UIAlertAction(title: "投稿をブロック", style: .destructive, handler: { [self] action in
            self.showConfirmAlert()
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showConfirmAlert() {
        let alertController = UIAlertController(title: "", message: "投稿をブロックしてもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ブロック", style: .destructive, handler: { [self] action in
            self.removePost(postDocPass: doc)
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    //ブラウザのユーザー通報ページに遷移
    func toReportPage() {
        let url = NSURL(string: "https://site-2671642-9832-2847.mystrikingly.com/")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    
    //投稿非表示(削除)処理
    func removePost(postDocPass: String) {
        db.collection("post").document(doc).delete() { error in
            if error != nil {
                print("投稿削除エラー: \(error.debugDescription)")
            } else {
                print("削除しました")
            }
        }
        navigationController?.popViewController(animated: true)
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
        let shareImage = imageView.image //投稿された画像
        let text = textView.text //投稿された文章
        let username = userId //投稿者のTwitterアカウント
        let shareTextWithUsername = "\(text ?? "")\n@\(username)"
        let activityItems = [shareImage as Any, shareTextWithUsername] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
}
