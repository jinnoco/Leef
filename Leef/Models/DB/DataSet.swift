//
//  DataSet.swift
//  Leef
//
//  Created by J on 2021/07/29.
//

import Foundation
import Firebase
struct DataSet {
    
    let uid: String
    let username: String
    let postImageURLString: String
    let comment: String
    let profileImageURLString: String
    let userId: String
    let postDate: Timestamp
    let docId: String
    
}

struct MyDataSet {
    let uid: String
    let username: String
    let postImageData: String
    let comment: String
    let profileImageURLString: String
    let userId: String
    let postDate: Timestamp
    let docId: String
}
