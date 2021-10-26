//
//  ContactDescriptionViewController.swift
//  Leef
//
//  Created by J on 2021/08/30.
//

import UIKit

class ContactDescriptionViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetDiscription().setDiscription(view: view, discriptionImage: #imageLiteral(resourceName: "Contact_Description"))
        
    }
    
}
