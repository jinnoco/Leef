//
//  PostPageViewController.swift
//  Leef
//
//  Created by J on 2021/07/23.
//

import UIKit
import Firebase
import SoftUIView
import NVActivityIndicatorView

class PostPageViewController: UIViewController {
    
    
    
    // UI
    var postImageView = UIImageView()
    var postImage = UIImage()
    let topLabel = UILabel()
    let postButton = SoftUIView()
    let cancelButton = SoftUIView()
    let textView = UITextView()
    let postButtonLabel = UILabel()
    let sampleText = "コメントを入力...\n\n例)\n・写真の食材の詳細\n・廃棄までの期限\n・お店の情報、宣伝"
    
    var textViewY: CGFloat?
    var color = MainColor()
    let screenSize = UIScreen.main.bounds.size
    
    let database = Firestore.firestore()
    
    override func loadView() {
        
        configureTopLabel()
        configureCancelButton()
        configurePostButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configurePostImageView()
        configureTextView()
        
        // 初期状態ではタップ不可
        postButton.isEnabled = false
        postButtonLabel.textColor = color.darkGrayColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = color.backColor
        textView.delegate = self
        
        // キーボードの表示・非表示を通知
        NotificationCenter.default.addObserver(self, selector: #selector(PostPageViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PostPageViewController.keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardHeight = ((userInfo[UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        textViewY = textView.top // ここでtextViewの元のY位置を取得
        textView.frame.origin.y = screenSize.height - keyboardHeight - textView.frame.height - 20 // textViewを動かす
    }
    
    @objc
    func keyboardWillHide(_ notification: NSNotification) {
        if let textViewY = textViewY {
            // 取得したY位置に戻す
            textView.frame.origin.y = textViewY
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder() // タップでキーボードを閉じる
    }
    
    
    
    func configurePostImageView() {
        view.addSubview(postImageView)
        setImage()
        postImageView.image = postImage
        postImageView.contentMode = .scaleAspectFit
    }
    
    func configureTopLabel() {
        view.addSubview(topLabel)
        setTopLabel()
        topLabel.text = "新規投稿を作成"
        topLabel.font = UIFont(name: "AvenirNext-Bold", size: 15)
        topLabel.textColor = color.darkGrayColor
    }
    
    func configureCancelButton() {
        view.addSubview(cancelButton)
        setCancelButton()
        cancelButton.mainColor = color.backColor.cgColor
        cancelButton.darkShadowColor = color.darkShadow.cgColor
        cancelButton.lightShadowColor = color.lightShadow.cgColor
        let buttonHeght = view.frame.size.height * 0.05
        cancelButton.cornerRadius = buttonHeght / 2
        // Button内にLabelを表示
        let label = UILabel()
        cancelButton.setContentView(label)
        label.text = "キャンセル"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.darkGrayColor
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    func configurePostButton() {
        view.addSubview(postButton)
        setPostButton()
        postButton.mainColor = color.backColor.cgColor
        postButton.darkShadowColor = color.darkShadow.cgColor
        postButton.lightShadowColor = color.lightShadow.cgColor
        let buttonHeght = view.frame.size.height * 0.05
        postButton.cornerRadius = buttonHeght / 2
        postButton.setContentView(postButtonLabel)
        postButtonLabel.text = "投稿"
        postButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        postButtonLabel.centerXAnchor.constraint(equalTo: postButton.centerXAnchor).isActive = true
        postButtonLabel.centerYAnchor.constraint(equalTo: postButton.centerYAnchor).isActive = true
        postButtonLabel.font = UIFont(name: "AvenirNext-Bold", size: 13)
        postButtonLabel.textColor = color.blueColor
        postButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        
    }
    
    
    
    func configureTextView() {
        view.addSubview(textView)
        setTextView()
        textView.backgroundColor = color.whiteColor
        textView.text = sampleText
        textView.textColor = .lightGray // placeholderの色
        textView.layer.cornerRadius = 15
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 内側に余白をつける
        textView.sizeToFit()
    }
    
    func setImage() {
        let imageHeight = view.frame.size.height * 0.3
        let imageWidth = imageHeight * (4 / 3)
        let constant = view.frame.size.height * 0.04
        postImageView.translatesAutoresizingMaskIntoConstraints                                             = false
        postImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                        = true
        postImageView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: constant).isActive     = true
        postImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive                          = true
        postImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive                        = true
    }
    
    
    
    
    func setTopLabel() {
        let topConstant = view.frame.size.height * 0.07
        topLabel.translatesAutoresizingMaskIntoConstraints                                      = false
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                 = true
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive  = true
    }
    
    
    
    
    func setCancelButton() {
        let bottomConstant = view.frame.size.height * 0.15
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        cancelButton.translatesAutoresizingMaskIntoConstraints                                                  = false
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                             = true
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomConstant).isActive    = true
        cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive                              = true
        cancelButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive                             = true
    }
    
    
    
    func setPostButton() {
        let buttonHeght = view.frame.size.height * 0.05
        let buttonWidth = buttonHeght * 6.25
        postButton.translatesAutoresizingMaskIntoConstraints                                            = false
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                       = true
        postButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -30).isActive     = true
        postButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive                        = true
        postButton.heightAnchor.constraint(equalToConstant: buttonHeght).isActive                       = true
    }
    
    
    
    func setTextView() {
        let height = view.frame.size.height * 0.2
        textView.translatesAutoresizingMaskIntoConstraints                                          = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
        textView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 15).isActive   = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive       = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive    = true
        textView.heightAnchor.constraint(equalToConstant: height).isActive                          = true
        
    }
    
    
    @objc
    func send() {
        // データのnilテェック
        if let postImageData = postImage.jpegData(compressionQuality: 1.0),
           let comment = textView.text,
           let uid = Auth.auth().currentUser?.uid,
           let username = Auth.auth().currentUser?.displayName,
           let profileImageURL = Auth.auth().currentUser?.photoURL,
           let userId = UserDefaults.standard.string(forKey: "userId") {
            // SendDBModelに格納
            let sendDBModel = SendDBModel(username: username, uid: uid, postImageData: postImageData, comment: comment, profileImageURLString: profileImageURL.absoluteString, userId: userId)
            // FireStoreに送信
            sendDBModel.sendData()
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc
    func cancel() {
        dismiss(animated: true, completion: nil)
        postImageView.image = nil
    }
    
    
    
}

// textViewに関する処理
extension PostPageViewController: UITextViewDelegate {
    
    // textViewに入力されたらPlaceHolderを消し本文の色を黒にする
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == sampleText {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    // textViewが空白だったらPlaceHolderを表示し文字をグレーにする
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = sampleText
            textView.textColor = .lightGray
        }
    }
    
    
    // textViewにPlaceHolderがある場合、空白の場合は投稿ボタンを押せないようにしボタンの文字色をグレーにする
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.text == sampleText || textView.text == "" {
            postButton.isEnabled = false
            postButtonLabel.textColor = color.darkGrayColor
        } else {
            postButton.isEnabled = true
            postButtonLabel.textColor = color.blueColor
        }
    }
    
    
    
    
}
