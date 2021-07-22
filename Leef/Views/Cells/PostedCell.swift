//
//  PostedCell.swift
//  Leef
//
//  Created by J on 2021/07/19.
//

import UIKit

class PostedCell: UITableViewCell {
    
    var color = MainColor()
    
    var delegate: UIViewController?
    
    var image = UIImageView()
    var trashButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        configureImage()
        configureTrashButton()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configureImage() {
        addSubview(image)
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 10
        setupImage()
    }
    
    func setupImage() {
        
        let imageHeight = frame.size.height * 3
        let imageWidth = imageHeight * (4/3)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        image.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        image.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
       
    }
    
    
    func configureTrashButton() {
        addSubview(trashButton)
        setupTrashButton()
        contentView.isUserInteractionEnabled = false
        let trashImage = UIImage(systemName: "trash.circle")
        trashButton.setImage(trashImage, for: .normal)
        trashButton.tintColor = .lightGray
        trashButton.contentHorizontalAlignment = .fill
        trashButton.contentVerticalAlignment = .fill
        trashButton.addTarget(self, action: #selector(removePost), for: .touchUpInside)
    }
    
    func setupTrashButton() {
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        trashButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 140).isActive = true
        trashButton.bottomAnchor.constraint(equalTo: image.topAnchor).isActive = true
        trashButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        trashButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func removePost() {
        print("removePost")
        showAlert()
    }
    
    func showAlert() {
        let ac = UIAlertController(title: nil, message: "この投稿を削除してもよろしいですか？", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "削除", style: .destructive, handler: { (action: UIAlertAction) in
                        //投稿を削除
                        print("removeAction")
                        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)

        ac.addAction(removeAction)
        ac.addAction(cancel)

        delegate?.present(ac, animated: true, completion: nil)
    }
}
