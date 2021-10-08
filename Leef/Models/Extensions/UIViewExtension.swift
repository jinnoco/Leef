//
//  UIViewExtension.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                               = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive             = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive   = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive       = true
    }
    
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
}
