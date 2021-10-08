//
//  UIImageExtension.swift
//  Leef
//
//  Created by J on 2021/07/27.
//

import Nuke
import UIKit

extension UIImageView {
    
    
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        loadImage(with: url)
    }
    
    func loadImage(with url: URL) {
        Nuke.loadImage(with: url, into: self)
    }

}
