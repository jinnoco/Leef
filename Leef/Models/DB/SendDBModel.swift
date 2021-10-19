//
//  SendDBModel.swift
//  Leef
//
//  Created by J on 2021/07/06.
//

import UIKit
import Firebase

class SendDBModel {
    
    public var username = String()
    public var uid = String()
    public var userId = String()
    public var postImageData = Data()
    public var comment = String()
    public var profileImageURLString = String()
    public var database = Firestore.firestore()
    public var postUsername = UserDefaults.standard.string(forKey: "userId")
    
    init() {
        
    }
    
    init(username: String, uid: String, postImageData: Data, comment: String, profileImageURLString: String, userId: String) {
        self.username = username
        self.uid = uid
        self.postImageData = postImageData
        self.comment = comment
        self.profileImageURLString = profileImageURLString
        self.userId = userId
    }
    
    
    
    public func sendData() {
        
        let imageRef = Storage.storage().reference().child("PostImages")
            .child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(postImageData, metadata: nil) { _, error in
            if error != nil {
                print("データ送信エラー: \(error.debugDescription)")
                return
            }
            
            imageRef.downloadURL { [self] url, error in
                if error != nil {
                    return
                }
                
                let dicData = ["username": self.username,
                               "uid": self.uid,
                               "postImageURLString": url?.absoluteString as Any,
                               "comment": self.comment,
                               "profileImageURLString": self.profileImageURLString,
                               "userId": self.userId,
                               "postDate": Timestamp()
                ]
                
                self.database.collection("post").document().setData(dicData)
                print("送信完了")
            }
        }
    }
    
}
