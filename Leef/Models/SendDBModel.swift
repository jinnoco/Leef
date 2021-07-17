//
//  SendDBModel.swift
//  Leef
//
//  Created by J on 2021/07/06.
//

import UIKit
import Firebase

class SendDBModel {
    
    //送信機能
    
    init() {
        
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
    
    //FireStorage
    func sendImageData(data: Data) {
        let image = UIImage(data: data)
        let postImage = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("postImage").child("\(UUID().uuidString + String(Date.timeIntervalBetween1970AndReferenceDate)).jpg")
        
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
    
    //URLからImage
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
