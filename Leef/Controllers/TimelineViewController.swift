//
//  TimelineViewController.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit
import Firebase

class TimelineViewController: UIViewController {

    let tableView = UITableView()
    let cellIdentifier = "timelineCell"
    
    var username = String()
    

//    let tabBar = UITabBar()
    
    var cell = [TimelineCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
//        printURL()
        

        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.title = username
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toNewPostPage))
        navigationItem.hidesBackButton = true
       configureTableView()
        
    }
    
    @objc func toNewPostPage() {
        print("toNewPostPage")
        let postViewController = PostViewController()
        postViewController.modalPresentationStyle = .fullScreen
        present(postViewController, animated: true, completion: nil)
    }
    
//    func printURL() {
//        let user = Auth.auth().currentUser
//        if let user = user {
//            let imageURL = user.photoURL
//            print("imageURL: ", imageURL)
//            print("type", type(of: imageURL))
//        }
//    }

    func configureTableView() {
        view.addSubview(tableView)
        setupTableView()
        tableView.rowHeight = 280
        tableView.register(TimelineCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.pin(to: view)
    }
    
    
   
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped cell")
        let selectViewController = SelectViewController()
        navigationController?.pushViewController(selectViewController, animated: true)
    }
    
    
}
