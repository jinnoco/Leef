//
//  MyPageViewController.swift
//  Leef
//
//  Created by J on 2021/07/18.
//

import UIKit

class MyPageViewController: UIViewController {
    
    var color = MainColor()
    
    var tableView = UITableView()
    let postedCellId = "postedCellId"
    
    var loginText = UILabel()
    var loginUserImage = UIImageView()
    var loginUsername = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.title = "マイページ"
        
        view.backgroundColor = #colorLiteral(red: 0.9124667052, green: 0.9124667052, blue: 0.9124667052, alpha: 1)
        configureTableView()
        configureLoginText()
        configureLoginUserImage()
        configureLoginUsername()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    func configureLoginText() {
        view.addSubview(loginText)
        loginText.text = "ログイン中："
        loginText.font = UIFont.systemFont(ofSize: 13)
        setupLoginText()
    }
    
    func setupLoginText() {
        let posTop = view.frame.size.height * 0.15
        let constant = view.frame.size.width * 0.07
        loginText.translatesAutoresizingMaskIntoConstraints = false
        loginText.centerYAnchor.constraint(equalTo: view.topAnchor, constant: posTop).isActive = true
        loginText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        
    }
    
    func configureLoginUserImage() {
        view.addSubview(loginUserImage)
        setupLoginUserImage()
        loginUserImage.backgroundColor = color.lightGrayColor
        loginUserImage.layer.cornerRadius = (view.frame.size.height * 0.05) / 2
    }
    
    func setupLoginUserImage() {
        let height = view.frame.size.height * 0.05
        let width = height
        loginUserImage.translatesAutoresizingMaskIntoConstraints = false
        loginUserImage.centerYAnchor.constraint(equalTo: loginText.centerYAnchor).isActive = true
        loginUserImage.leadingAnchor.constraint(equalTo: loginText.trailingAnchor, constant: 20).isActive = true
        loginUserImage.heightAnchor.constraint(equalToConstant: height).isActive =  true
        loginUserImage.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func configureLoginUsername(){
        view.addSubview(loginUsername)
        setupLoginUsername()
        loginUsername.text = "LoginUsername"
    }
    
    func setupLoginUsername() {
        loginUsername.translatesAutoresizingMaskIntoConstraints = false
        loginUsername.centerYAnchor.constraint(equalTo: loginUserImage.centerYAnchor).isActive = true
        loginUsername.leadingAnchor.constraint(equalTo: loginUserImage.trailingAnchor, constant: 15).isActive = true
    }
    
    
    
    func configureTableView() {

        view.addSubview(tableView)
        tableView.register(PostedCell.self, forCellReuseIdentifier: postedCellId)
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let posTop = view.frame.size.height * 0.2
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: posTop).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    


}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postedCellId, for: indexPath) as! PostedCell
        cell.selectionStyle = .none
        cell.delegate  = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("postedCell")
    }
    
    
    
}
