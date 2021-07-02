//
//  TimelineViewController.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit

class TimelineViewController: UIViewController {

    let tableView = UITableView()
    let cellIdentifier = "timelineCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "タイムライン"
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonTapped))
    
       configureTableView()
        
    }
    
    @objc func createButtonTapped() {
        print("createButtonTapped")
    }

    func configureTableView() {
        view.addSubview(tableView)
        setupTableView()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped cell")
        let selectViewController = SelectViewController()
        navigationController?.pushViewController(selectViewController, animated: true)
    }
    
    
}
