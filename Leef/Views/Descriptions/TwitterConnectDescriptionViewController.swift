//
//  TwitterConnectDescriptionViewController.swift
//  Leef
//
//  Created by J on 2021/08/30.
//

import UIKit

class TwitterConnectDescriptionViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetDiscription().setDiscription(view: view, discriptionImage: #imageLiteral(resourceName: "TwitterConnect_Description"))
            
    }
    
}
