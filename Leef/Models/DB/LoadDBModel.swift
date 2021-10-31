//
//  LoadDBModel.swift
//  Leef
//
//  Created by J on 2021/07/19.
//

import UIKit
import Firebase

protocol LoadDelegate: AnyObject {
    func doneLoad(check: Int)
}

class LoadDBModel {
    
    public var dataSets = [DataSet]()
    public var myDataSet = [MyDataSet]()
    
    var db = Firestore.firestore()
    
    public var myUid = Auth.auth().currentUser?.uid
    public weak var loadDelegate: LoadDelegate?
    
    func loadPostData() {
        db.collection("post").order(by: "postDate").addSnapshotListener { [self] snapshot, error in
            
            self.dataSets = []
            
            if error != nil {
                print("dataSetsデータ受信エラー: ", error.debugDescription)
                return
            }
            
            if let snapshotDoc = snapshot?.documents {
                
                for doc in snapshotDoc {
                    
                    let data = doc.data()
                    
                    if let uid = data["uid"] as? String,
                       let username = data["username"] as? String,
                       let postImageData = data["postImageURLString"] as? String,
                       let comment = data["comment"] as? String,
                       let  profileImageURLString = data["profileImageURLString"]  as? String,
                       let userId = data["userId"] as? String,
                       let docId = doc.documentID as? String,
                       let postDate = data["postDate"] as? Timestamp {
                        
                        
                        let newDataSet = DataSet(uid: uid, username: username, postImageURLString: postImageData, comment: comment, profileImageURLString: profileImageURLString, userId: userId, postDate: postDate, docId: docId)
                        
                        self.dataSets.append(newDataSet)
                        self.dataSets.reverse()
                        self.loadDelegate?.doneLoad(check: 1)
                        
                    }
                }
                print("全体の投稿: \(dataSets.count)件")
            }
        }
    }
    
    
    func loadMyPostData() {
        
        db.collection("post").order(by: "postDate").addSnapshotListener { [self]snapshot, error in
            
            self.myDataSet = []
            
            if error != nil {
                print("myDataSet受信エラー: ", error.debugDescription)
                return
            }
            
            if let snapshotDoc = snapshot?.documents {
                
                for doc in snapshotDoc {
                    
                    let data = doc.data()
                    
                    if let uid = data["uid"] as? String,
                       let username = data["username"] as? String,
                       let postImageData = data["postImageURLString"] as? String,
                       let comment = data["comment"] as? String,
                       let  profileImageURLString = data["profileImageURLString"] as? String,
                       let userId = data["userId"] as? String,
                       let docId = doc.documentID as? String,
                       let postDate = data["postDate"] as? Timestamp
                    {
                        
                        if myUid == uid {
                            let newMyDataSet = MyDataSet(uid: uid, username: username, postImageData: postImageData, comment: comment, profileImageURLString: profileImageURLString, userId: userId, postDate: postDate, docId: docId)
                            
                            self.myDataSet.append(newMyDataSet)
                            self.myDataSet.reverse()
                            
                        }
                    }
                }
            }
            print("myDataSetデータ受信完了")
            print("自分の投稿: \(myDataSet.count)件")
            self.loadDelegate?.doneLoad(check: 2)
        }
    }
    
}
