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
    let timelineCellId = "timelineCell"
    
    var username = String()
    
    var post = [TimelineCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
       configureNav()
       configureTableView()
        
    }
    

    func configureNav() {
        navigationItem.title = "タイムライン"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.title = username
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toNewPostPage))
        navigationItem.hidesBackButton = true
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

        tableView.register(TimelineCell.self, forCellReuseIdentifier: timelineCellId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: timelineCellId, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped cell")
        let selectViewController = SelectViewController()
        navigationController?.pushViewController(selectViewController, animated: true)
    }
    

    
}
