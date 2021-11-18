//
//  ImagePicker.swift
//  Leef
//
//  Created by J on 2021/10/18.
//

import UIKit
import Firebase

extension TimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func openCamera() {
        let sourceType: UIImagePickerController.SourceType = .camera
        // カメラ利用チェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = false
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    
    private func openLibrary() {
        let sourceType: UIImagePickerController.SourceType = .photoLibrary
        // フォトライブラリ利用チェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = false
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if info[.originalImage] as? UIImage != nil {
            // 画像をセットして画面遷移
            if let selectedImage = info[.originalImage] as? UIImage {
                postPageViewContorller.postImage = selectedImage
                picker.dismiss(animated: true, completion: nil)
                postPageViewContorller.modalPresentationStyle = .fullScreen
                present(postPageViewContorller, animated: true, completion: nil)
                
            } else {
                return
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc
    public func showAlert() {
        
        let user = Auth.auth().currentUser?.displayName
        let openCamera = UIAlertAction(title: "カメラで撮影", style: .default, handler: { _ in self.openCamera() })
        let openLibrary = UIAlertAction(title: "ライブラリから選択", style: .default, handler: { _ in self.openLibrary() })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        let done = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        if user != nil {
            let actionSheet = UIAlertController(title: "新しい投稿を作成します", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
            actionSheet.addAction(openCamera)
            actionSheet.addAction(openLibrary)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true, completion: nil)
            
            // UITest
            actionSheet.view.accessibilityIdentifier = "createPostAlert"
            openLibrary.accessibilityIdentifier = "openLibrary"
            
        } else if user == nil {
            let alertController = UIAlertController(title: "確認", message: "投稿機能を利用するにはTwitterアカウントを連携してください", preferredStyle: .alert)
            alertController.addAction(done)
            present(alertController, animated: true, completion: nil)
            
            alertController.view.accessibilityIdentifier = "confirmAlert"
        }
        
        
        
    }
    
}
