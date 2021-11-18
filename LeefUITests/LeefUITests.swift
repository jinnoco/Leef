//
//  LeefUITests.swift
//  LeefUITests
//
//  Created by J on 2021/11/16.
//

import XCTest
import Firebase

class LeefUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCTContext.runActivity(named: "launch app") { _ in
            FirebaseApp.configure()
            app.launch()
        }
    }
    
    
    func testChangeTab() {
        XCTContext.runActivity(named: "タブの切り替え") { _ in
            app.buttons["myPageTabBarButton"].tap()
            app.buttons["supportPageTabBarButton"].tap()
            app.buttons["timelinePageTabBarButton"].tap()
        }
    }
    
    
    func testCheckPostButtonIsEnabled() throws {
        XCTContext.runActivity(named: "投稿作成挙動") { _ in
            
            let userUid = Auth.auth().currentUser?.uid
            
            app.navigationBars.buttons["createPostButton"].tap()
            
            if userUid != nil {
                
                app.sheets["createPostAlert"].scrollViews.otherElements.buttons["openLibrary"].tap()
                app.scrollViews.otherElements.images["Photo, August 09, 2012, 3:52 AM"].tap()
                let postButton = app.otherElements["postButton"]
                
                XCTAssertFalse(postButton.isEnabled)
                
                let textView = app.textViews["commentTextView"]
                textView.tap()
                textView.typeText("テスト投稿サンプル")
                
                XCTAssertTrue(postButton.isEnabled)
                
            } else {
                
                let alert = app.alerts["confirmAlert"]
                let staticTexts = alert.staticTexts["確認"]
                
                XCTAssertTrue(staticTexts.exists)
                
                alert.buttons["OK"].tap()
                
            }
        }
    }
    
    
    func testSelectPost() throws {
        XCTContext.runActivity(named: "セルの選択,シェアボタン") { _ in
            let cell = app.cells["timelineCell"]
            XCTAssertTrue(cell.exists)
            cell.tap()
            app.otherElements["shreButton"].tap()
            let activityViewController = app.otherElements["activityViewController"]
            XCTAssertTrue(activityViewController.exists)
        }
    }
    
    
    func testPostAlert() throws {
        XCTContext.runActivity(named: "ブロックの二重確認") { _ in
            
            let cell = app.cells["timelineCell"]
            XCTAssertTrue(cell.exists)
            cell.tap()
            
            app.buttons["alertButton"].tap()
            
            let reportAlert = app.alerts["reportAlert"]
            XCTAssertTrue(reportAlert.exists)
            reportAlert.buttons["投稿をブロック"].tap()
            
            let blockAlert = app.alerts["confirmBlockAlert"]
            blockAlert.buttons["キャンセル"].tap()
        }
    }
    
    
    func testLogout() throws {
        
        let userUid = Auth.auth().currentUser?.uid
        
        XCTContext.runActivity(named: "ログイン状況による表示チェック") { _ in
            app.buttons["myPageTabBarButton"].tap()
            app.navigationBars.buttons["Twitter連携"].tap()
            let logoutActionButton = app.sheets["logoutAlert"].scrollViews.otherElements.buttons["連携を解除"]
            let noPostTextlabel = app.staticTexts["noPostTextlabel"]
            
            if userUid != nil {
                
                XCTAssertTrue(logoutActionButton.exists)
                logoutActionButton.tap()
                XCTAssertTrue(noPostTextlabel.exists)
                let  username = app.staticTexts["username"]
                XCTAssertEqual(username.label, "Twitter連携を完了してください")
                
            } else {
                XCTAssertFalse(noPostTextlabel.exists)
            }
        }
        
    }
    
    func testLoginUsername() throws {
        XCTContext.runActivity(named: "ログインユーザー名チェック") { _ in
            app.buttons["myPageTabBarButton"].tap()
            let  username = app.staticTexts["username"]
            
            XCTAssertEqual(username.label, "Leef")
        }
    }
    
    
    
    
}
