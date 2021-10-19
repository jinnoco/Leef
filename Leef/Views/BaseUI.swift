//
//  BaseUI.swift
//  Leef
//
//  Created by J on 2021/10/18.
//

import UIKit
import SoftUIView

struct BaseUI {
    public let textFont = "AvenirNext-Bold"
}

struct ConfigureSoftUIButton {
    
    var color = MainColor()
    var baseUI = BaseUI()
    
    func setButtonColor(button: SoftUIView) {
        button.mainColor = color.backColor.cgColor
        button.darkShadowColor = color.darkShadow.cgColor
        button.lightShadowColor = color.lightShadow.cgColor
    }
    
    func setButtonLabel(button: SoftUIView, labelText: String, fontSize: CGFloat, textColor: UIColor) {
        let label = UILabel()
        label.text = labelText
        button.setContentView(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        label.font = UIFont(name: baseUI.textFont, size: fontSize)
        label.textColor = textColor
    }
}
