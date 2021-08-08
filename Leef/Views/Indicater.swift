//
//  Indicater.swift
//  Leef
//
//  Created by J on 2021/07/29.
//

import NVActivityIndicatorView

class Indicater {
    
    var activityIndicaterView: NVActivityIndicatorView!
    
    func configureIndicater(to superView: UIView) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicaterView = NVActivityIndicatorView(frame: frame, type: .ballRotateChase, color: .lightGray, padding: .none)
        activityIndicaterView.center = superView.center
        superView.addSubview(activityIndicaterView)
        
    }

    func startIndicater() {
        activityIndicaterView.startAnimating()
    }
    
    func stopIndicater() {
        activityIndicaterView.stopAnimating()
    }
}
