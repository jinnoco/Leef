//
//  AppleLogin.swift
//  Leef
//
//  Created by J on 2021/10/18.
//

import UIKit
import AuthenticationServices
import CryptoKit
import Firebase


private var currentNonce: String?

class AppleLogin {
    
    @available(iOS 13.0, *)
    @objc
    func handleTappedAppleLoginButton(_ sender: ASAuthorizationAppleIDButton) {
        // ランダムの文字列を生成
        let nonce = randomNonceString()
        // delegateで使用するため代入
        currentNonce = nonce
        // requestを作成
        let request = ASAuthorizationAppleIDProvider().createRequest()
        // sha256で変換したnonceをrequestのnonceにセット
        request.nonce = sha256(nonce)
        // controllerをインスタンス化する(delegateで使用するcontroller)
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = LoginViewController()
        controller.presentationContextProvider = LoginViewController()
        controller.performRequests()
    }
    
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    
    
}


extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    
    // 認証が成功した時に呼ばれる関数
    func authorizationController(controller _: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // credentialが存在するかチェック
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        // nonceがセットされているかチェック
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        // credentialからtokenが取得できるかチェック
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        // tokenのエンコードを失敗
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        // 認証に必要なcredentialをセット
        let credential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: idTokenString,
            rawNonce: nonce
        )
        // Firebaseへのログインを実行
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                // 必要に応じて
                return
            }
            if let authResult = authResult {
                print(authResult)
                // 画面遷移など行う
                let mainTabBarController = MainTabBarController()
                self.navigationController?.pushViewController(mainTabBarController, animated: true)
            }
        }
    }
    
    // delegateのプロトコルに設定されているため、書いておく
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
        
    }
    // Appleのログイン側でエラーがあった時に呼ばれる
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
    
    
}
