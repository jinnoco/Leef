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
    
    // UI
    public var username = UILabel()
    private var profileImageView = UIImageView()
    private var imageView = UIImageView()
    public var textView = UITextView()
    private var twitterButton = SoftUIView()
    private var shareButton = SoftUIView()
    private let alertButton = UIButton()
    
    private var baseUI = BaseUI()
    private var softUI = ConfigureSoftUIButton()
    private var openURL = OpenURL()
    private var webURL = URLs()
    private var color = MainColor()
    
    public var profileImageString = String()
    public var postImageString = String()
    public var userId = String()
    public var doc = String() // 投稿非表示機能用
    
    
    override func loadView() {
        super.loadView()
        
        configureShareButton()
        configureTwitterButton()
        configureTextView()
        configureImageView()
        configureProfileImage()
        configureUsename()
        configureAlertButton()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBarsOnSwipe = false // スワイプで非表示を無効
    }
    
    private func configureProfileImage() {
        view.addSubview(profileImageView)
        setProfileImage()
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 22
        profileImageView.backgroundColor = color.blueColor
        profileImageView.loadImage(with: profileImageString)
    }
    
    private func configureUsename() {
        view.addSubview(username)
        setUsername()
        username.font = UIFont(name: baseUI.textFont, size: 18)
        username.textColor = color.darkGrayColor
    }
    
    
    private func configureAlertButton() {
        view.addSubview(alertButton)
        alertButton.setImage(UIImage(systemName: "exclamationmark.bubble"), for: .normal)
        alertButton.tintColor = color.darkGrayColor
        alertButton.addTarget(self, action: #selector(tappedAlertButton), for: .touchUpInside)
        setAlertButton()
    }
    
    
    private func setAlertButton() {
        alertButton.translatesAutoresizingMaskIntoConstraints                                   = false
        alertButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive  = true
        alertButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive       = true
    }
    
    
    
    private func configureImageView() {
        view.addSubview(imageView)
        setImageView()
        imageView.loadImage(with: postImageString)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.setupImageViewer()
    }
    
    private func configureTextView() {
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
    
    private func configureTwitterButton() {
        view.addSubview(twitterButton)
        setTwitterButton()
        let buttonHeght = view.frame.size.height * 0.05
        twitterButton.cornerRadius = buttonHeght / 2
        softUI.setButtonColor(button: twitterButton)
        softUI.setButtonLabel(button: twitterButton, labelText: "問い合わせる", fontSize: 13, textColor: color.blueColor) // Button内にLabelを配置
        twitterButton.addTarget(self, action: #selector(toTwitterWebPage), for: .touchUpInside)
    }
    
    private func configureShareButton() {
        view.addSubview(shareButton)
        setShareButton()
        shareButton.clipsToBounds = false
        let buttonHeght = view.frame.size.height * 0.05
        shareButton.cornerRadius = buttonHeght / 2
        softUI.setButtonColor(button: shareButton)
        softUI.setButtonLabel(button: shareButton, labelText: "シェアする", fontSize: 13, textColor: color.darkGrayColor) // Button内にLabelを配置
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
    }
    
    
    
    private func setProfileImage() {
        profileImageView.translatesAutoresizingMaskIntoConstraints                                      = false
        profileImageView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive  = true
        profileImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive            = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive                           = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive                          = true
    }
    
    
    
    
    private func setUsername() {
        username.translatesAutoresizingMaskIntoConstraints                                                  = false
        username.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive                 = true
        username.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive  = true
    }
    
    
    
    private func setImageView() {
        let imageHeight = view.frame.size.height * 0.25
        let imageWidth = imageHeight * (4 / 3)
        let constant = view.frame.size.height * 0.04
        imageView.translatesAutoresizingMaskIntoConstraints                                            = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                       = true
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -constant).isActive   = true
        imageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive                         = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive                       = true
    }
    
    
    private func setTextView() {
        textView.translatesAutoresizingMaskIntoConstraints                                          = false
        textView.widthAnchor.constraint(equalTo: twitterButton.widthAnchor).isActive                = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive                             = true
        textView.bottomAnchor.constraint(equalTo: twitterButton.topAnchor, constant: -30).isActive  = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
    }
    
    
    
    
    
    private func setTwitterButton() {
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        twitterButton.translatesAutoresizingMaskIntoConstraints                                         = false
        twitterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                    = true
        twitterButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -25).isActive   = true
        twitterButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive                     = true
        twitterButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive                    = true
    }
    
    
    
    private func setShareButton() {
        let bottomConstant = view.frame.size.height * 0.20
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        shareButton.translatesAutoresizingMaskIntoConstraints                                                  = false
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                             = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomConstant).isActive    = true
        shareButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive                              = true
        shareButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive                             = true
        
    }
    
    @objc
    private func tappedAlertButton() {
        let report = UIAlertAction(title: "ユーザー通報ページへ", style: .destructive, handler: { _ in self.toReportPage() })
        let block = UIAlertAction(title: "投稿をブロック", style: .destructive, handler: { [self] _ in self.showConfirmAlert() })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        let alertController = UIAlertController(title: "不適切なコンテンツですか？", message: "", preferredStyle: .alert)
        alertController.addAction(report)
        alertController.addAction(block)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    private func showConfirmAlert() {
        let block = UIAlertAction(title: "ブロック", style: .destructive, handler: { [self] _ in self.removePost(postDocPass: doc) })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        let alertController = UIAlertController(title: "", message: "投稿をブロックしてもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(block)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    // ブラウザのユーザー通報ページに遷移
    private func toReportPage() {
        openURL.toWebPage(url: webURL.reportPageURL)
    }
    
    
    // 投稿非表示(削除)処理
    private func removePost(postDocPass: String) {
        let database = Firestore.firestore()
        database.collection("post").document(doc).delete { error in
            if error != nil {
                print("投稿削除エラー: \(error.debugDescription)")
            } else {
                print("削除しました")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func toTwitterWebPage() {
        // 外部ブラウザまたはTwitterアプリで投稿者のページを開く
        let userId = userId
        openURL.toWebPage(url: "https://twitter.com/\(userId)")
    }
    
    
    
    @objc
    private func share() {
        // ActivityViewControllerを表示しSNSにシェア
        guard let shareImage = imageView.image else { return } // 投稿された画像
        guard let text = textView.text else { return } // 投稿された文章
        let username = userId // 投稿者のTwitterアカウント
        let shareTextWithUsername = "\(text)\n@\(username)"
        let activityItems = [shareImage as Any, shareTextWithUsername] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
}
