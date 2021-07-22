//
//  MainTabBarController.swift
//  Leef
//
//  Created by J on 2021/07/18.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
      
    }
    
   
    func setupTab() {
        
//        var viewControllers = [UIViewController]()

        
        let timelineViewController = TimelineViewController()
        timelineViewController.tabBarItem = UITabBarItem(title: "タイムライン", image: UIImage(systemName: "newspaper"), tag: 0)
        let timelineNVC = UINavigationController(rootViewController: timelineViewController)
                
        let myPageViewController = MyPageViewController()
        myPageViewController.tabBarItem = UITabBarItem(title: "マイページ", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        let myPageNVC = UINavigationController(rootViewController: myPageViewController)

        setViewControllers([timelineNVC, myPageNVC], animated: false)
        
//        self.viewControllers = viewControllers.map{ UINavigationController(rootViewController: $0)}
//        self.setViewControllers(viewControllers, animated: false)
    }


    
}
