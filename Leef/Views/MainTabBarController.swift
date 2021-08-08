//
//  MainTabBarController.swift
//  Leef
//
//  Created by J on 2021/07/18.
//

import UIKit
import NeumorphismTab



class MainTabBarController: NeumorphismTabBarController {
    
    var color = MainColor()
    
    override func setupView() {
        
        let timeline = NeumorphismTabBarItem(icon: UIImage(systemName: "newspaper")!, title: "")
        let myPage = NeumorphismTabBarItem(icon: UIImage(systemName: "person.crop.circle")!, title: "")
        
        view.backgroundColor = color.backColor
        
        let timelineViewController = TimelineViewController()
        let timelineNVC = UINavigationController(rootViewController: timelineViewController)
        
        let myPageViewController = MyPageViewController()
        let myPageNVC = UINavigationController(rootViewController: myPageViewController)
        
        setTabBar(items: [timeline, myPage])
        setViewControllers([timelineNVC, myPageNVC], animated: false)
        
    }
}
