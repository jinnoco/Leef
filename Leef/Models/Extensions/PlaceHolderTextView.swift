//
//  PlaceHolderTextView.swift
//  Leef
//
//  Created by J on 2021/07/05.
//

import UIKit

class PlaceHolderTextView: UITextView {

     var placeHolder: String = "" {
        willSet {
            self.placeHolderLabel.text = newValue
            self.placeHolderLabel.sizeToFit()
        }
    }

     lazy var placeHolderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: 0.0, height: 0.0)) 
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textColor = .lightGray
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        changeVisiblePlaceHolder()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }

    private func changeVisiblePlaceHolder() {
        self.placeHolderLabel.alpha = (self.placeHolder.isEmpty || !self.text.isEmpty) ? 0.0 : 1.0
    }

    @objc private func textChanged(notification: NSNotification?) {
        changeVisiblePlaceHolder()
    }

}
