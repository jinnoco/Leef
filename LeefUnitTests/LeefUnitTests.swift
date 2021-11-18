//
//  LeefUnitTests.swift
//  LeefUnitTests
//
//  Created by J on 2021/10/15.
//

import XCTest
import Firebase
import UIKit
@testable import Leef

class LeefUnitTest: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        FirebaseApp.configure()
    }
    
    
    func testLoadSample() throws {
        let docRef = Firestore.firestore().collection("post").document("Al5UreEcHDV7h1otEAfZ")
        docRef.getDocument { snapshot, _ in
            if let data = snapshot?.data() {
                if let uid = data["uid"] as? String {
                    print("uid: ", uid)
                    XCTAssertEqual(uid, "SxSsncfbWjhflcbHN3Z8KFlOSVz1")
                }
            }
        }
    }
    
    
    
    func testTwitterWeb() throws {
        let selectVC = SelectViewController()
        selectVC.userId = "LeefApp_"
        XCTAssertEqual(selectVC.toTwitterWebPage(), "https://twitter.com/LeefApp_")
        
        selectVC.userId = "NotLeef"
        XCTAssertNotEqual(selectVC.toTwitterWebPage(), "https://twitter.com/Leef")
    }
    
}
