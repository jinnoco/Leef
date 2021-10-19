//
//  DataSet.swift
//  Leef
//
//  Created by J on 2021/07/29.
//

import Foundation
import Firebase

struct DataSet {
    public var uid: String
    public var username: String
    public var postImageURLString: String
    public var comment: String
    public var profileImageURLString: String
    public var userId: String
    public var postDate: Timestamp
    public var docId: String
}

struct MyDataSet {
    public var uid: String
    public var username: String
    public var postImageData: String
    public var comment: String
    public var profileImageURLString: String
    public var userId: String
    public var postDate: Timestamp
    public var docId: String
}
