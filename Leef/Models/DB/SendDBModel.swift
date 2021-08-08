//
//  SendDBModel.swift
//  Leef
//
//  Created by J on 2021/07/06.
//

import UIKit
import Firebase

class SendDBModel {
    
    var username = String()
    var uid = String()
    var userId = String()
    var postImageData = Data()
    var comment =  String()
    var profileImageURLString = String()
    
    
    
    let db = Firestore.firestore()
    let postUsername = UserDefaults.standard.string(forKey: "userId")
    
    
    //送信機能
    
    init() {
        
    }
    
    init(username: String, uid: String, postImageData: Data, comment: String, profileImageURLString: String, userId: String) {
        self.username = username
        self.uid = uid
        self.postImageData  = postImageData
        self.comment = comment
        self.profileImageURLString = profileImageURLString
        self.userId = userId
        
    }
    
    
    
    func sendData() {
        
        let imageRef = Storage.storage().reference().child("PostImages")
            .child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(postImageData, metadata: nil) { metadata, error in
            if error != nil {
                print("データ送信エラー: \(error.debugDescription)")
                return
            }
            
            imageRef.downloadURL { [self] url, error in
                if error != nil {
                    return
                }
                
                let dicData = ["username" : self.username,
                               "uid" : self.uid,
                               "postImageURLString" : url?.absoluteString as Any,
                               "comment": self.comment,
                               "profileImageURLString" : self.profileImageURLString,
                               "userId" : self.userId,
                               "postDate" : Timestamp()
                ]
                
                self.db.collection("post").document().setData(dicData)
                print("送信完了")
            }
        }
    }
}



