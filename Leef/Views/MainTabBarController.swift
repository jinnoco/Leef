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
        
        guard let newspaperIcon = UIImage(systemName: "newspaper") else { return }
        guard let personIcon = UIImage(systemName: "person.crop.circle") else { return }
        guard let infoIcon = UIImage(systemName: "info.circle") else { return }
        
        let timeline = NeumorphismTabBarItem(icon: newspaperIcon, title: "")
        let myPage = NeumorphismTabBarItem(icon: personIcon, title: "")
        let supportPage = NeumorphismTabBarItem(icon: infoIcon, title: "")
        
        view.backgroundColor = color.backColor
        
        let timelineViewController = TimelineViewController()
        let timelineNVC = UINavigationController(rootViewController: timelineViewController)
        
        let myPageViewController = MyPageViewController()
        let myPageNVC = UINavigationController(rootViewController: myPageViewController)
        
        let supportPageViewController = SupportPageViewController()
        let supportPageNVC = UINavigationController(rootViewController: supportPageViewController)
        
        setTabBar(items: [timeline, myPage, supportPage])
        setViewControllers([timelineNVC, myPageNVC, supportPageNVC], animated: false)
        
    }
}
