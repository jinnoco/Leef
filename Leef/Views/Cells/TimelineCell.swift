//
//  TimelineCell.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit
import Firebase
import Nuke
import SoftUIView

class TimelineCell: UITableViewCell {
    
    let background = UIView()
    var username = UILabel()
    var profileImage = UIImageView()
    var timelineImageView = UIImageView()
    var dateLabel = UILabel()
    
    let sendDBModel = SendDBModel()
    let loadDBModel = LoadDBModel()
    let color = MainColor()
    let user = Auth.auth().currentUser
    let timeline = TimelineViewController()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell setup

        addSubview(background)
        addSubview(timelineImageView)
        addSubview(username)
        addSubview(dateLabel)
        addSubview(profileImage)
        
        configureBackground()
        configureProfileImage()
        configureUsername()
        configureTimelineImageView()
        configureDateLabel()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
  
    func configureBackground() {
        setBackground()
        background.backgroundColor = color.cellColor
        background.layer.cornerRadius = 22
        background.layer.masksToBounds = true
        backgroundColor = color.backColor
    }
    
    
    func configureTimelineImageView() {
        setTimelineImage()
        timelineImageView.contentMode = .scaleAspectFill
        timelineImageView.backgroundColor = color.whiteColor
        timelineImageView.clipsToBounds = true
        timelineImageView.layer.cornerRadius = 15
    }
    
    
    func configureProfileImage() {
        setPrfileImage()
        profileImage.backgroundColor = .lightGray
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 22
        
    }
    
    
    func setBackground() {
        background.translatesAutoresizingMaskIntoConstraints                                    = false
        background.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive              = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive       = true
        background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive      = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive   = true
    }
    
    
    func setTimelineImage() {
        timelineImageView.translatesAutoresizingMaskIntoConstraints                                         = false
        timelineImageView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive   = true
        timelineImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive           = true
        timelineImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive        = true
        timelineImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70).isActive            = true
        timelineImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    

    
    func configureUsername() {
        setUsername()
        username.font = UIFont(name: "AvenirNext-Bold", size: 15)
        username.textColor = color.darkGrayColor
    }

    func setUsername() {
        username.translatesAutoresizingMaskIntoConstraints                                              = false
        username.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive                 = true
        username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20).isActive  = true

    }

    func configureDateLabel() {
        setDateLabel()
        dateLabel.textColor = color.darkGrayColor
    }

    func setDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints                                             = false
        dateLabel.leadingAnchor.constraint(equalTo: timelineImageView.leadingAnchor).isActive           = true
        dateLabel.topAnchor.constraint(equalTo: timelineImageView.bottomAnchor, constant: 15).isActive  = true
    }

    func setPrfileImage() {
        profileImage.translatesAutoresizingMaskIntoConstraints                                 = false
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive           = true
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive   = true
        profileImage.widthAnchor.constraint(equalToConstant: 44).isActive                      = true
        profileImage.heightAnchor.constraint(equalToConstant: 44).isActive                     = true
    }
    
}
