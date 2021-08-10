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
    
    
    
    var color = MainColor()
    var loadDBModel = LoadDBModel()
    let db = Firestore.firestore()
    var provider: OAuthProvider?
    
    var tableView = UITableView()
    let postedCellId = "postedCellId"
    var loginText = UILabel()
    var loginUserImage = UIImageView()
    var loginUsername = UILabel()
    let label = UILabel()
    
    let indicater = Indicater()
    
    var animationView = AnimationView()
    
    
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = color.backColor
        
        
        configureLoginText()
        configureLoginUserImage()
        configureLoginUsername()
        configureNav()
        
        indicater.configureIndicater(to: view)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang":"ja"]
        
        self.loadDBModel.loadMyPostData()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadDBModel.loadDelegate = self
        
        //自分の投稿の有無によってUIを変更
        checkMyPostForView()
     
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
        self.loadDBModel.loadMyPostData()
        
        //自分の投稿の有無によってUIを変更
        if loadDBModel.myDataSet.count == 0 {
            configureAnimation()
            configureLabel()
        } else {
            loadDBModel.loadMyPostData()
            tableView.reloadData()
            configureTableView()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animationView.removeFromSuperview()
        label.removeFromSuperview()
    }
    
    func doneLoad(check: Int) {
        //LoadDBModelの処理が完了したら実行
        if check == 2 {
            tableView.reloadData()
            checkMyPostForView()
        }
    }
    
    
    func checkMyPostForView() {
        //LoadDBModelの処理が完了したら呼ばれる
        if loadDBModel.myDataSet.count != 0 {
            configureTableView()
        }
      
    }
    
    
    func configureNav() {
        navigationItem.title = "マイページ"
        changeNavRightBar()
//        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "ログアウト", style: .plain, target: self, action: #selector(showAlert))
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: color.darkGrayColor]
        navigationController?.navigationBar.barTintColor = color.backColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = color.darkGrayColor
    }
    
    func changeNavRightBar() {
        let username = Auth.auth().currentUser?.displayName
        if loginUsername.text != username {
            navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "ログイン", style: .plain, target: self, action: #selector(showLoginAlert))
        } else {
            navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "ログアウト", style: .plain, target: self, action: #selector(showAlert))
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
        view.addSubview(label)
        setLabel()
        label.text = "まだ投稿は作成されていません"
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = color.darkGrayColor
        
    }
    
    
    
    func configureLoginText() {
        view.addSubview(loginText)
        loginText.text = "ログイン中："
        loginText.font = UIFont(name: "AvenirNext-Bold", size: 13)
        loginText.textColor = color.darkGrayColor
        setLoginText()
    }
    
    func configureLoginUserImage() {
        view.addSubview(loginUserImage)
        setLoginUserImage()
        let user = Auth.auth().currentUser
        if let user = user {
            let photoURL = user.photoURL
            loginUserImage.loadImage(with: photoURL!)
        }
        loginUserImage.backgroundColor = color.lightGrayColor
        loginUserImage.clipsToBounds = true
        loginUserImage.layer.cornerRadius = (view.frame.size.height * 0.05) / 2
    }
    
    func configureLoginUsername(){
        view.addSubview(loginUsername)
        setLoginUsername()
        loginUsername.text = Auth.auth().currentUser?.displayName ?? "username"
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
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints                             = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive        = true
        label.topAnchor.constraint(equalTo: animationView.bottomAnchor).isActive    = true
    }
    
    
    
    
    func setLoginText() {
        let topConstant = view.frame.size.height * 0.15
        let constant = view.frame.size.width * 0.07
        loginText.translatesAutoresizingMaskIntoConstraints                                             = false
        loginText.centerYAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive     = true
        loginText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive    = true
    }
    
    
    
    
    
    
    func setLoginUserImage() {
        let height = view.frame.size.height * 0.05
        let width = height
        loginUserImage.translatesAutoresizingMaskIntoConstraints                                             = false
        loginUserImage.centerYAnchor.constraint(equalTo: loginText.centerYAnchor).isActive                   = true
        loginUserImage.leadingAnchor.constraint(equalTo: loginText.trailingAnchor, constant: 20).isActive    = true
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
    
    @objc func showLoginAlert(){
        print("ログインする")
        
        let modalViewController = ModalViewController()
//        modalViewController.modalPresentationStyle = .fullScreen
        present(modalViewController, animated: true, completion: nil)
        
            /*
        
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: { [self] (credential, error) in
            
            if error != nil {
                print("ログイン処理エラー: \(error.debugDescription)")
                return
            }
            
            indicater.startIndicater()
            
            if credential != nil {
                Auth.auth().signIn(with: credential!) { (result, error) in
                    if error != nil {
                        print("ログイン処理エラー: \(error.debugDescription)")
                        return
                    }
                    //@usernameを取得しUserDefaultsに保存
                    print("result?.additionalUserInfo?.providerID -> Twitter @username: \(result?.additionalUserInfo?.profile!["screen_name"])")
                    let userId = result?.additionalUserInfo?.profile!["screen_name"] as! String
                    UserDefaults.standard.setValue(userId, forKey: "userId")
                    
                    indicater.stopIndicater()
                    
                    loadDBModel.loadMyPostData()
                    
                    let user = Auth.auth().currentUser
                    if let user = user {
                        let photoURL = user.photoURL
                        loginUserImage.loadImage(with: photoURL!)
                        
                        loginUsername.text = Auth.auth().currentUser?.displayName
                        
                        changeNavRightBar()
                        
                    }
                    
                }
            }
        })
        
 */
        
    }
    
    
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "", message: "ログアウトしてもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ログアウト", style: .default, handler: { action in
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
            try firebaseAuth.signOut()
            print("ログアウトしました")
            
            loginUsername.text = "ログインしていません"
            loginUserImage.image =  nil
            changeNavRightBar()
            
            loadDBModel.loadMyPostData()
            
//            let loginViewController = LoginViewController()
//            loginViewController.modalPresentationStyle = .fullScreen
//            loginViewController.modalTransitionStyle = .flipHorizontal
//            present(loginViewController, animated: true, completion: nil)
            
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postedCellId, for: indexPath) as! PostedCell
        
        let myPostImage = cell.postedImageView
        myPostImage.loadImage(with: loadDBModel.myDataSet[indexPath.row].postImageData)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DocumentIDを取得して渡す
        let doc = loadDBModel.myDataSet[indexPath.row].docId
        showDeleteAlert(postDocPass: doc)
        
    }
    
    
    func showDeleteAlert(postDocPass: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "投稿を削除", style: .destructive, handler: { [self] action in
            //didSelectRowAtで取得したDocumentIDを渡す
            self.delete(doc: postDocPass)
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func delete(doc: String) {
        //didSelectRowAtで取得したDocumentIDを使用して削除処理を行う
        db.collection("post").document(doc).delete() { [self] error in
            if error != nil {
                print("投稿削除エラー: \(error.debugDescription)")
            } else {
                print("削除しました")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //自分の投稿が0になった時の処理
                if loadDBModel.myDataSet.count == 0 {
                    self.configureAnimation()
                    self.configureLabel()
                }
            }
        }
    }
    
    
    
    
}
