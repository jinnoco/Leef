//
//  WalkthroughViewController.swift
//  Leef
//
//  Created by J on 2021/08/26.
//

import UIKit

class WalkthroughViewController: UIPageViewController {
    
    var color = MainColor()
    
    private var pageViewController: UIPageViewController!
    private var controllers: [ UIViewController ] = []
    
    private var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.initPageViewController()
        self.setPageControl()
        
    }
    
    private func initPageViewController() {
        
        // 表示するViewController作成、表示配列に保存
        let leefDescription = LeefDescriptionViewController() as UIViewController
        let twitterConnectDescription = TwitterConnectDescriptionViewController() as UIViewController
        let postContentDescription = PostContentDescriptionViewController() as UIViewController
        let contactDescription = ContactDescriptionViewController() as UIViewController
        let firstView = FirstViewController() as UIViewController
        
        controllers = [leefDescription, twitterConnectDescription, postContentDescription, contactDescription ,firstView]
        
        //UIPageViewController設定
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        //ViewControllerに追加
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view!)
    }
    
    private func setPageControl() {
        
        // PageControlの配置場所
        self.pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 100, width: UIScreen.main.bounds.width,height: 50))
        // 全ページ数
        self.pageControl.numberOfPages = self.controllers.count
        // 表示ページ
        self.pageControl.currentPage = 0
        // インジケータの色
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // 現在ページのインジケータの色
        self.pageControl.currentPageIndicatorTintColor = color.darkGrayColor
        
        self.view.addSubview(self.pageControl)
    }
    
    
}


extension WalkthroughViewController: UIPageViewControllerDataSource {
    
    // ページ数
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    // 左にスワイプ（進む）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
           index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }
    
    // 右にスワイプ （戻る）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
           index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
    
}

extension WalkthroughViewController: UIPageViewControllerDelegate {
    
    //アニメーション終了後処理 追加
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentPage = pageViewController.viewControllers![0]
        self.pageControl.currentPage = self.controllers.firstIndex(of: currentPage)!
    }
    
}
