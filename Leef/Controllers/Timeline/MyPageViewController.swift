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

class MyPageViewController: UIViewController, LoadDelegate, loginDelegate {
    
    
    // UI
    internal var tableView = UITableView()
    private var loginUserImage = UIImageView()
    private var loginUsername = UILabel()
    private var noPostTextlabel = UILabel()
    private var animationView = AnimationView()
    
    private let postedCellId = "postedCellId"
    private var color = MainColor()
    var loadDBModel = LoadDBModel()
    var twitterLogin = TwitterLogin()
    private var baseUI = BaseUI()
    private var userWithTwitter = Auth.auth().currentUser?.displayName
    
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = color.backColor
        
        configureLoginUserImage()
        configureLoginUsername()
        configureNav()
        
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
                
        twitterLogin.loginDelegate = self
        loadDBModel.loadDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // displayName -> Twitterログイン有無チェック
        // uid -> Firebase認証有無チェック
        
        userWithTwitter = Auth.auth().currentUser?.displayName
        
        if userWithTwitter != nil {
            
            let userUid = Auth.auth().currentUser?.uid
            loadDBModel.myUid = userUid
            loadDBModel.loadMyPostData()
            
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
    
    
    
    
    private func configureNav() {
        changeNavRightBar()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: color.darkGrayColor]
        navigationController?.navigationBar.barTintColor = color.backColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = color.darkGrayColor
    }
    
    
    private func changeNavRightBar() {
        
        if userWithTwitter == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLoginAlert))
        } else if userWithTwitter != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLogoutAlert))
        }
    }
    
    private func configureAnimation() {
        
        animationView = AnimationView(name: LottieAnimation().myPageAnimation)
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
    }
    
    
    private func configureLabel() {
        view.addSubview(noPostTextlabel)
        setLabel()
        noPostTextlabel.text = "まだ投稿は作成されていません"
        noPostTextlabel.font = baseUI.defaultFont(fontSise: 13)
        noPostTextlabel.textColor = color.darkGrayColor
        
    }
    
    
    private func configureLoginUserImage() {
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
    
    private func configureLoginUsername() {
        view.addSubview(loginUsername)
        setLoginUsername()
        loginUsername.text = Auth.auth().currentUser?.displayName ?? "Twitter連携を完了してください"
        loginUsername.font = baseUI.defaultFont(fontSise: 13)
        loginUsername.textColor = color.darkGrayColor
        
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostedCell.self, forCellReuseIdentifier: postedCellId)
        tableView.backgroundColor = color.backColor
        tableView.separatorStyle = .none
        setTableView()
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc
    private func handleRefreshControl() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    private func setLabel() {
        noPostTextlabel.translatesAutoresizingMaskIntoConstraints                             = false
        noPostTextlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive        = true
        noPostTextlabel.topAnchor.constraint(equalTo: animationView.bottomAnchor).isActive    = true
    }
    
    
    
    private func setLoginUserImage() {
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
    
    
    
    private func setLoginUsername() {
        loginUsername.translatesAutoresizingMaskIntoConstraints                                                  = false
        loginUsername.centerYAnchor.constraint(equalTo: loginUserImage.centerYAnchor).isActive                   = true
        loginUsername.leadingAnchor.constraint(equalTo: loginUserImage.trailingAnchor, constant: 15).isActive    = true
    }
    
    
    private func setTableView() {
        let topConstant = view.frame.size.height * 0.2
        tableView.translatesAutoresizingMaskIntoConstraints                                         = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive     = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                    = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                  = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive                      = true
    }
    
    @objc
    func showLoginAlert() {
        print("ログアウトユーザー")
        let modalViewController = ModalViewController()
        present(modalViewController, animated: true, completion: nil)
    }
    
    
    private func setView() {
        
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
        print("ログイン済ユーザー")
        let alertController = UIAlertController(title: "連携済", message: "連携解除してもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "連携を解除", style: .default, handler: { _ in
            // ログアウト処理
            self.twitterLogin.logout()
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    public func setLogoutTableView() {
        tableView.removeFromSuperview()
        configureAnimation()
        configureLabel()
    }

    
    func checkLogin(check: Int) {
        
//         ログアウト後
//         自分の投稿あり → tableView消す、文字とUserImage変更
//         自分の投稿なし → 文字とUserImageのみ変更
         
        if check == 3 {
            setLogoutTableView()
        } else if check == 4 {
            setLogoutTableView()
            setLogoutView()
        }
    }
    
    
    
    public func setLogoutView() {
        loginUsername.text = "Twitter連携を完了してください"
        loginUserImage.image = #imageLiteral(resourceName: "NoUser")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Twitter連携", style: .plain, target: self, action: #selector(showLoginAlert))
    }
    
    private func showDeleteAlert(postDocPass: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "投稿を削除", style: .destructive, handler: { [self] _ in
            // didSelectRowAtで取得したDocumentIDを渡す
            self.delete(doc: postDocPass)
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func delete(doc: String) {
        // didSelectRowAtで取得したDocumentIDを使用して削除処理を行う
        let database = Firestore.firestore()
        database.collection("post").document(doc).delete { [self] error in
            if error != nil {
                print("投稿削除エラー: \(error.debugDescription)")
            } else {
                print("投稿削除")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
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
    
    
}
