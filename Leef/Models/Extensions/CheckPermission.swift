//
//  CheckPermission.swift
//  Leef
//
//  Created by J on 2021/08/06.
//

import Photos

class CheckPermission {
    
    func showCheckPermission() {
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch status {
            
            case .authorized:
                print("許可")
                
            case .denied:
                print("拒否")
                
            case .notDetermined:
                print("notDetermined")
                
            case .restricted:
                print("restricted")
                
            case .limited:
                print("limited")
            @unknown default: break
                
            }
            
        }
    }
    
}
