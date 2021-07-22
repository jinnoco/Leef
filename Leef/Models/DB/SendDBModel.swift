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
    var userImageData = String()
    var postImageData = Data()
    var comment =  String()
    
    let db = Firestore.firestore()
    
    //送信機能
    
    init() {
        
    }
    
    init(username: String, userImageData: String, postImageData: Data, comment: String) {
        self.username = username
        self.userImageData = userImageData
        self.postImageData  = postImageData
        self.comment = comment
    }
    
//    func sendProfileImageData(imageURL: URL) {
//        let user = Auth.auth().currentUser
//        let userImageURL = user?.photoURL
//
//        //        let image = UIImage(data: imageURL)
//        //        let profileImage = image?.jpegData(compressionQuality: 0.1)
        
//        let imageRef = Storage.storage().reference().child("profileImage").child("\(userImageURL!.absoluteString).jpg")
//
//        imageRef.downloadURL { url, error in
//            if error != nil {
//                return
//            }
//
//            UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
//        }
//    }
    
    func sendPostData() {
        
        let imageRef = Storage.storage().reference().child("PostImages")
            .child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(postImageData, metadata: nil) { metadata, error in
            if error != nil {
                print("sendError", error)
                return
            }
            
            imageRef.downloadURL { [self] url, error in
                if error != nil {
                    
                    return
                }
                
                self.db.collection("post").document().setData(["username" : self.username,
                                                               "userImageData" : self.userImageData,
                                                               "postImageData" : url?.absoluteString as Any,
                                                               "comment": self.comment])
            }
        
        }
        
    }
    
    //FireStorage
    func sendImageData(data: Data) {
        let image = UIImage(data: data)
        let postImage = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("postImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(postImage!, metadata: nil) { metadata, error in
            if error != nil {
                return
            }
            imageRef.downloadURL { url, error in
                if error != nil {
                    return
                }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "postImage")
                
            }
            
        }
    }
    
    //URLからImageに変換
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
    
//    func sendProfileImageData(url: String) {
//
//
//        let stringURL = url
//        let image = UIImage(url: stringURL)
//
//        let data = image?.jpegData(compressionQuality: 0.1)
//
//        let storageRef = Storage.storage().reference(forURL: stringURL).child("Item")
//
//        storageRef.putData(data!, metadata: nil) { metadata, error in
//            if error != nil {
//                 return
//            }
//        }
//    }
    
    func sendProfileImageData(url: String) {
    
        let stringURL = url
        let image = UIImage(url: stringURL)
        
        let data = image?.jpegData(compressionQuality: 0.1)
        
        let storageRef = Storage.storage().reference().child("profileImage").child(stringURL)
        
        storageRef.putData(data!, metadata: nil) { metadata, error in
            if error != nil {
                 return
            }
        }
    }
    
}

extension UIImage {
    
    public convenience init?(url:String) {
        let url = URL(string: url)
        do{
            let data = try Data(contentsOf: url!)
            self.init(data: data)
            return
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
        self.init()
    }

}
