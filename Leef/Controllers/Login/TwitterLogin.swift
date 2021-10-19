//
//  TwitterLogin.swift
//  Leef
//
//  Created by J on 2021/10/18.
//

import UIKit
import Firebase

class TwittreLogin: UIViewController {
    
    var provider: OAuthProvider?
    let indicater = Indicater()
    
    var loadDBModel = LoadDBModel()
    var myPageViewController = MyPageViewController()
    
    @objc
    func login() {
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login": "true"]
        provider?.getCredentialWith(nil, completion: { [self] (credential, error) in
            
            if error != nil {
                print("ログイン処理エラー: \(error.debugDescription)")
                return
            }
            
            indicater.startIndicater()
            
            if let credential = credential {
                Auth.auth().signIn(with: credential) { (result, error) in
                    
                    if error != nil {
                        print("ログイン処理エラー: \(error.debugDescription)")
                        return
                    }
                    // @usernameを取得しUserDefaultsに保存
                    guard let userInfo = result?.additionalUserInfo?.profile else { return }
                    if let userId = userInfo["screen_name"] as? String {
                        print("result?.additionalUserInfo?.providerID -> Twitter @username: \(userId)")
                        UserDefaults.standard.setValue(userId, forKey: "userId")
                    }
                    
                    indicater.stopIndicater()
                    
                    let mainTabBarController = MainTabBarController()
                    navigationController?.pushViewController(mainTabBarController, animated: true)
                    
                }
            }
        })
    }
    
    
     public func logout() {
        let firebaseAuth = Auth.auth()
        self.navigationController?.popViewController(animated: true)
        do {
            if loadDBModel.myDataSet.isEmpty == false {
              
                myPageViewController.setLogoutTableView()
            }
            try firebaseAuth.signOut()
            print("ログアウトしました")
            
            myPageViewController.setLogoutView()
            
        } catch let error as NSError {
            print("ログアウトエラー: \(error.debugDescription)")
        }
    }

    
}


