//
//  PostedCell.swift
//  Leef
//
//  Created by J on 2021/07/19.
//

import UIKit
import Firebase
import Nuke

class PostedCell: UITableViewCell {
    
    var color = MainColor()
    weak var delegate: UIViewController?
    
    var postedImageView = UIImageView()
    var trashButton = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = color.backColor
        configurePostedImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configurePostedImageView() {
        addSubview(postedImageView)
        setupPostedImageView()
        postedImageView.contentMode = .scaleAspectFill
        postedImageView.layer.cornerRadius = 12
        postedImageView.clipsToBounds = true
    }
    
    func setupPostedImageView() {
        
        postedImageView.translatesAutoresizingMaskIntoConstraints                                   = false
        postedImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive             = true
        postedImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive     = true
        postedImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive  = true
        postedImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive      = true
        postedImageView.heightAnchor.constraint(equalToConstant: 250).isActive                      = true
        
    }
    
    
}
