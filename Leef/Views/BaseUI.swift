//
//  BaseUI.swift
//  Leef
//
//  Created by J on 2021/10/18.
//

import UIKit
import SoftUIView

struct BaseUI {
    func defaultFont(fontSise: CGFloat) -> UIFont {
        guard let font = UIFont(name: "AvenirNext-Bold", size: fontSise) else { return UIFont.systemFont(ofSize: fontSise) }
        return  font
    }
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
        label.font = baseUI.defaultFont(fontSise: fontSize)
        label.textColor = textColor
    }
}
