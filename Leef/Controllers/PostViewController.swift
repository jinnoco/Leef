//
//  PostViewController.swift
//  Leef
//
//  Created by J on 2021/07/04.
//

import UIKit
import Firebase



class PostViewController: UIViewController {
    
    var color = MainColor()
    
    var sendDBModel = SendDBModel()
    
    let topLabel = UILabel()
   
    var image = UIImageView()
    let imageLabel = UILabel()
    let label = UILabel()
    var textView = UITextView()
    let createButton = UIButton()
    let cancelButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.whiteColor
        
//        print(image.image ?? "nil")

        
//        configureProfileImage()
        
        configureTopLabel()
        configureCancelButton()
        configureCreateButton()
        configureImage()
        configureImageLabel()
        configureLabel()
        configureTextView()
    }
    
    
    
    func configureTopLabel() {
        view.addSubview(topLabel)
        setupTopLabel()
        topLabel.text = "新規投稿を作成"
    }
    
    func setupTopLabel() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
    }
    
    func configureCancelButton() {
        view.addSubview(cancelButton)
        setupCancelButton()
        cancelButton.setTitle("キャンセル", for: .normal)
        cancelButton.setTitleColor(color.blueColor, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
    }
    
    func setupCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -120).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor).isActive = true

    }
    
    func configureCreateButton() {
        view.addSubview(createButton)
        setupCreateButton()
        createButton.setTitle("追加", for: .normal)
        createButton.setTitleColor(color.whiteColor, for: .normal)
        createButton.backgroundColor = color.blueColor
        createButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        createButton.layer.cornerRadius = 15.0
        createButton.addTarget(self, action: #selector(create), for: .touchUpInside)
   
    }
    
    func setupCreateButton() {
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 125).isActive = true
        createButton.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
//
//    func configureProfileImage() {
//        let user = Auth.auth().currentUser
//        if let user = user {
//            let photoURL = user.photoURL
//            let urlString = photoURL?.absoluteString
//            image.image = getImageByUrl(url: urlString!)
//        }
//
//    }
//

    
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        return UIImage()
    }
    
    func configureImage() {
//        let noImage = UIImage(named: "noImage")
//        image = UIImageView(image: noImage)
        view.addSubview(image)
        setupImage()
        image.backgroundColor = color.lightGrayColor
        image.layer.cornerRadius = 20
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
    }

    func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 140).isActive = true
        image.heightAnchor.constraint(equalToConstant: 192).isActive = true
        image.widthAnchor.constraint(equalToConstant: 256).isActive = true
    }
    

    
    func configureImageLabel() {
        view.addSubview(imageLabel)
        setupImageLabel()
        imageLabel.text = "タップして写真を選択"
        hideText()
        
    }
    
    func setupImageLabel() {
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor).isActive = true
    }
    
    func hideText() {
        if image.image != nil  {
            imageLabel.isHidden = true
        } else{
            imageLabel.isHidden = false
        }
    }
    
    func configureLabel() {
        view.addSubview(label)
        setupLabel()
        label.text = "説明文を入力"
        label.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: image.bottomAnchor, constant: 23).isActive = true
        label.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 5).isActive = true
    }
    
    func configureTextView() {
        view.addSubview(textView)
        setupTextView()
        textView.delegate = self
        textView.backgroundColor = color.lightGrayColor
        textView.layer.cornerRadius = 15
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.sizeToFit()
    }

    func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6).isActive = true
        textView.widthAnchor.constraint(equalTo: image.widthAnchor).isActive =  true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive =  true
    }
    
    @objc func create() {
        print("createButtonTapped!!")
        
        let data = image.image?.jpegData(compressionQuality: 0.1)
        sendDBModel.sendImageData(data: data!)
        

    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectImage() {
        print("selectImage")
        showAlert()
    }
    
   
       
    
}

extension PostViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    
    func doAlbum(){
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //アルバム利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            image.image = selectedImage
            imageLabel.isHidden = true
            image.layer.cornerRadius = 10
            picker.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    //アラート
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.doAlbum()
        }
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
