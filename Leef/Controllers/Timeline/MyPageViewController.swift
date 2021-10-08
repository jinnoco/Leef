//
//  MyPageViewController.swift
//  Leef
//
//  Created by J on 2021/07/18.
//

import UIKit
import Firebase
import Nuke
import Lottie

class MyPageViewController: UIViewController, LoadDelegate {
    
    // UI
    var tableView = UITableView()
    var loginUserImage = UIImageView()
    var loginUsername = UILabel()
    let noPostTextlabel = UILabel()
    var animationView = AnimationView()
    
    let postedCellId = "postedCellId"
    var profileImageString = String()
    let indicater = Indicater()
    var color = MainColor()
    var loadDBModel = LoadDBModel()
    let database = Firestore.firestore()
    
    var userWithTwitter = Auth.auth().currentUser?.displayName
    
    var user: String?
    
    override func loadView() {
        
        view.backgroundColor = color.backColor
        
        configureLoginUserImage()
        configureLoginUsername()
        configureNav()
        indicater.configureIndicater(to: view)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 初回起動判定
        let userDefaults = UserDefaults.standard
        let firstLunchKey = "FirstLunchKeyForMyPageTutorial"
        let lunched = userDefaults.bool(forKey: firstLunchKey)
        if lunched {
            return
        } else {
            // 初回起動の場合はmodalでtutorialを表示
            UserDefaults.standard.set(true, forKey: firstLunchKey)
            let myPageTutorialViewController = MyPageTutorialViewController()
            present(myPageTutorialViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDBModel.loadDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewwillappear")
        
        userWithTwitter = Auth.auth().currentUser?.displayName
        
        if userWithTwitter != nil {
            // ログインテェック
            let userUid = Auth.auth().currentUser?.uid
            if userUid != nil {
                loadDBModel.myUid = userUid
                loadDBModel.loadMyPostData()
            } else {
                tableView.removeFromSuperview()
                configureAnimation()
                configureLabel()
            }
            
        } else if userWithTwitter == nil {
            tableView.removeFromSuperview()
            configureAnimation()
            configureLabel()
        }
        
        
        
    }
    
    func doneLoad(check: Int) {
        // LoadDBModelの処理が完了したら実行
        if check == 2 {
            setView()
            
            if loadDBModel.myDataSet.isEmpty {
                configureAnimation()
                configureLabel()
            } else {
                tableView.reloadData()
                configureTableView()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        animationView.removeFromSuperview()
        noPostTextlabel.removeFromSuperview()
    }
    
    
    
    
    func configureNav() {
        changeNavRightBar()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: color.darkGrayColor]
        navigationController?.navigationBar.barTintColor = color.backColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = color.darkGrayColor
    }
    
    
    func changeNavRightBar() {
        
        
        if userWithTwitter == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLoginAlert))
        } else if userWithTwitter != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLogoutAlert))
        }
    }
    
    func configureAnimation() {
        
        animationView = AnimationView(name: "lf30_editor_zozlaqwf")
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
    }
    
    
    func configureLabel() {
        view.addSubview(noPostTextlabel)
        setLabel()
        noPostTextlabel.text = "まだ投稿は作成されていません"
        noPostTextlabel.font = UIFont(name: "AvenirNext-Bold", size: 13)
        noPostTextlabel.textColor = color.darkGrayColor
        
    }
    
    
    func configureLoginUserImage() {
        view.addSubview(loginUserImage)
        setLoginUserImage()
        
        
        if userWithTwitter != nil {
            
            let user = Auth.auth().currentUser
            if user != nil {
                guard let photoURL = user?.photoURL else { return }
                loginUserImage.loadImage(with: photoURL)
            } else {
                loginUserImage.image = #imageLiteral(resourceName: "NoUser")
            }
            
        } else if userWithTwitter == nil {
            loginUserImage.image = #imageLiteral(resourceName: "NoUser")
        }
        
        
        loginUserImage.backgroundColor = color.lightGrayColor
        loginUserImage.clipsToBounds = true
        loginUserImage.layer.cornerRadius = (view.frame.size.height * 0.05) / 2
    }
    
    func configureLoginUsername() {
        view.addSubview(loginUsername)
        setLoginUsername()
        loginUsername.text = Auth.auth().currentUser?.displayName ?? "Twitter連携を完了してください"
        loginUsername.font = UIFont(name: "AvenirNext-Bold", size: 15)
        loginUsername.textColor = color.darkGrayColor
        
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostedCell.self, forCellReuseIdentifier: postedCellId)
        tableView.backgroundColor = color.backColor
        tableView.separatorStyle = .none
        setTableView()
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc
    func handleRefreshControl() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    func setLabel() {
        noPostTextlabel.translatesAutoresizingMaskIntoConstraints                             = false
        noPostTextlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive        = true
        noPostTextlabel.topAnchor.constraint(equalTo: animationView.bottomAnchor).isActive    = true
    }
    
    
    
    func setLoginUserImage() {
        let topConstant = view.frame.size.height * 0.15
        let constant = view.frame.size.width * 0.07
        let height = view.frame.size.height * 0.05
        let width = height
        loginUserImage.translatesAutoresizingMaskIntoConstraints                                             = false
        loginUserImage.centerYAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive     = true
        loginUserImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive    = true
        loginUserImage.heightAnchor.constraint(equalToConstant: height).isActive                             = true
        loginUserImage.widthAnchor.constraint(equalToConstant: width).isActive                               = true
    }
    
    
    
    func setLoginUsername() {
        loginUsername.translatesAutoresizingMaskIntoConstraints                                                  = false
        loginUsername.centerYAnchor.constraint(equalTo: loginUserImage.centerYAnchor).isActive                   = true
        loginUsername.leadingAnchor.constraint(equalTo: loginUserImage.trailingAnchor, constant: 15).isActive    = true
    }
    
    
    func setTableView() {
        let topConstant = view.frame.size.height * 0.2
        tableView.translatesAutoresizingMaskIntoConstraints                                         = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive     = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                    = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                  = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive                      = true
    }
    
    @objc
    func showLoginAlert() {
        let modalViewController = ModalViewController()
        present(modalViewController, animated: true, completion: nil)
    }
    
    
    func setView() {
        print("setview")
        
        userWithTwitter = Auth.auth().currentUser?.displayName
        
        if userWithTwitter != nil {
            
            let user = Auth.auth().currentUser
            if let user = user {
                guard let photoURL = user.photoURL else { return }
                loginUserImage.loadImage(with: photoURL)
                loginUsername.text = user.displayName
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLogoutAlert))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLoginAlert))
            }
            
        } else if userWithTwitter == nil {
            print("Twitter連携なしユーザー")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLoginAlert))
        }
        
        
    }
    
    @objc
    func showLogoutAlert() {
        let alertController = UIAlertController(title: "連携済", message: "連携解除してもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "連携を解除", style: .default, handler: { _ in
            //ログアウト処理
            self.logout()
            
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func logout() {
        let firebaseAuth = Auth.auth()
        self.navigationController?.popViewController(animated: true)
        do {
            if loadDBModel.myDataSet.isEmpty == false {
                tableView.removeFromSuperview()
                configureAnimation()
                configureLabel()
            }
            try firebaseAuth.signOut()
            print("ログアウトしました")
            
            loginUsername.text = "Twitter連携を完了してください"
            loginUserImage.image = #imageLiteral(resourceName: "NoUser")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLoginAlert))
            
        } catch let error as NSError {
            print("ログアウトエラー: \(error.debugDescription)")
        }
    }
    
    
    
    
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadDBModel.myDataSet.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: postedCellId, for: indexPath) as? PostedCell {
            
            let myPostImage = cell.postedImageView
            myPostImage.loadImage(with: loadDBModel.myDataSet[indexPath.row].postImageData)
            
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // DocumentIDを取得して渡す
        let doc = loadDBModel.myDataSet[indexPath.row].docId
        showDeleteAlert(postDocPass: doc)
        
    }
    
    
    func showDeleteAlert(postDocPass: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "投稿を削除", style: .destructive, handler: { [self] _ in
            // didSelectRowAtで取得したDocumentIDを渡す
            self.delete(doc: postDocPass)
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func delete(doc: String) {
        // didSelectRowAtで取得したDocumentIDを使用して削除処理を行う
        database.collection("post").document(doc).delete { [self] error in
            if error != nil {
                print("投稿削除エラー: \(error.debugDescription)")
            } else {
                print("削除しました")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
}
