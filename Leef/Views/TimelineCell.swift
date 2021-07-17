//
//  TimelineCell.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit
import Firebase

class TimelineCell: UITableViewCell {
    
    var sendDBModel = SendDBModel()
    
    var username = UILabel()
    var date = UILabel()
    var profileImage = UIImageView()
    var image = UIImageView()
    var text = UITextView()
    
    let user = Auth.auth().currentUser

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Cell setup
        configureUsername()
        configureDate()
        configureImage()
        configureProfileImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUsername() {
        addSubview(username)
        setupUsername()
        
        let displayName = user?.displayName
        username.text = displayName ?? "username"
        
    }
    
    func setupUsername() {
        username.translatesAutoresizingMaskIntoConstraints = false
        username.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        username.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75).isActive = true
        
    }
    
    func configureDate() {
        addSubview(date)
        setupDate()
        date.text = "7月6日"
        date.textColor = .lightGray
        
    }
    
    func setupDate() {
        date.translatesAutoresizingMaskIntoConstraints = false
        date.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 100).isActive = true
        date.centerYAnchor.constraint(equalTo: username.centerYAnchor).isActive = true
    }
    
    func configureImage() {
        addSubview(image)
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 10
        setupImage()
    }
    
    func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: username.leadingAnchor).isActive = true
//        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
////        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20).isActive = true
        image.widthAnchor.constraint(equalToConstant: 256).isActive = true
        image.heightAnchor.constraint(equalToConstant: 192).isActive = true
    }
    
    func configureProfileImage() {
        addSubview(profileImage)
        setupPrfileImage()
        profileImage.backgroundColor = .lightGray
        profileImage.layer.cornerRadius = 22
        
//        let data = UserDefaults.standard.object(forKey: "userImage")
//        let image = UIImage(data: data! as! Data)
//        profileImage.image = image
//        if let user = user {
//            let imageURL = user.photoURL
//            let urlString = imageURL?.absoluteString
//            profileImage.image = sendDBModel.getImageByUrl(url: urlString!)
//        }

    }

//    func getImageByUrl(url: String) -> UIImage{
//        let url = URL(string: url)
//        do {
//            let data = try Data(contentsOf: url!)
//            return UIImage(data: data)!
//        } catch let err {
//            print("Error : \(err.localizedDescription)")
//        }
//
//        return UIImage()
//    }
    
    func setupPrfileImage() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
//        profileImage.topAnchor.constraint(equalTo: username.topAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: username.centerYAnchor).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}
