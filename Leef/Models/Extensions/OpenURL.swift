//
//  OpenURL.swift
//  Leef
//
//  Created by J on 2021/10/18.
//

import UIKit

class OpenURL {
    func toWebPage(url: String) {
        guard let url = NSURL(string: url) else { return }
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
