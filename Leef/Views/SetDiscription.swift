//
//  SetDiscription.swift
//  Leef
//
//  Created by J on 2021/10/26.
//

import UIKit

class SetDiscription {
    
    var imageView = UIImageView()
    
    func setDiscription(view: UIView,discriptionImage: UIImage) {
        view.backgroundColor = MainColor().backColor
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.image = discriptionImage
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive     = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive  = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive      = true
    }
    
}
