//
//  TwitterLogin.swift
//  Leef
//
//  Created by J on 2021/10/26.
//

import UIKit
import Firebase

protocol loginDelegate: AnyObject {
    func checkLogin(check: Int)
}
class TwitterLogin {
    
    var provider: OAuthProvider?
    weak var loginDelegate: loginDelegate?
    
    @objc
    func login() {
        print("ログイン処理開始")
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login": "true"]
        provider?.getCredentialWith(nil, completion: { (credential, error) in
            
            if error != nil {
                print("ログイン処理エラー: \(error.debugDescription)")
                return
            }
            
            self.loginDelegate?.checkLogin(check: 1)
            
            guard let credential = credential else { return }
            Auth.auth().signIn(with: credential) { (result, error) in
                
                if error != nil {
                    print("ログイン処理エラー: \(error.debugDescription)")
                    return
                }
                // @usernameを取得しUserDefaultsに保存
                guard let userInfo = result?.additionalUserInfo?.profile else { return }
                guard let userId = userInfo["screen_name"] as? String else { return }
                print("result?.additionalUserInfo?.providerID -> Twitter @username: \(userId)")
                UserDefaults.standard.setValue(userId, forKey: "userId")
                
                self.loginDelegate?.checkLogin(check: 2)
                
            }
            
        })
    }
    
}
