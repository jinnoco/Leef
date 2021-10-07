//
//  TimelineViewController.swift
//  Leef
//
//  Created by J on 2021/07/02.
//

import UIKit
import Firebase
import Nuke
import SoftUIView

class TimelineViewController: UIViewController, LoadDelegate {
    
    let postPageViewContorller = PostPageViewController()
    let checkPermission = CheckPermission()
    let color = MainColor()
    let loadDBModel = LoadDBModel()
    
    // UI
    let tableView = UITableView()
    let timelineCellId = "timelineCell"
    let titleImage = UIImageView()
    
    
    
    override func loadView() {
        super.loadView()
        
        configureNav()
        configureTableView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(Auth.auth().currentUser?.displayName ?? "Twitter??")
        // 全体のPostDataをロード
        loadDBModel.loadPostData()
        tableView.reloadData()
        
        loadDBModel.loadDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        checkPermission.showCheckPermission()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 初回起動判定
        let userDefaults = UserDefaults.standard
        let firstLunchKey = "FirstLunchKeyForTimelineTutorial"
        let lunched = userDefaults.bool(forKey: firstLunchKey)
        
        if lunched {
            return
        } else {
            // 初回起動の場合はmodalでtutorialを表示
            UserDefaults.standard.set(true, forKey: firstLunchKey)
            let timelineTutorialViewController = TimelineTutorialViewController()
            present(timelineTutorialViewController, animated: true, completion: nil)
        }
    }
    
    
    func doneLoad(check: Int) {
        // ロード処理が完了したらreloadDataを実行
        if check == 1 {
            tableView.reloadData()
        }
    }
    
    
    // NavigationBar
    func configureNav() {
        // navigationBarを表示
        navigationController?.setNavigationBarHidden(false, animated: true)
        // rightBarButtonItem(投稿作成)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        // titleに画像をセット
        let image = UIImage(named: "navigationBarTitleImage")
        titleImage.image = image
        titleImage.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImage
        // clearのleftBarButtonItemをセットして画像が左によらないようにする
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .clear
        // 色を設定
        navigationController?.navigationBar.barTintColor = color.backColor // 背景
        navigationController?.navigationBar.tintColor = color.darkGrayColor // アイテム
        // 下線を消す
        navigationController?.navigationBar.shadowImage = UIImage()
        // スワイプで隠す
        navigationController?.hidesBarsOnSwipe = true
        // 戻るボタン非表示
        navigationItem.hidesBackButton = true
        // 遷移先の戻るボタンのテキストを消す
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    
    @objc func toNewPostPage() {
        // 新規投稿作成ページに遷移
        let postPageViewController = PostPageViewController()
        postPageViewController.modalPresentationStyle = .fullScreen
        present(postPageViewController, animated: true, completion: nil)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TimelineCell.self, forCellReuseIdentifier: timelineCellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = color.backColor
        setTableView()
        
    }
    
    func setTableView() {
        configureRefreshControl()
        tableView.pin(to: view)
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
    
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadDBModel.dataSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: timelineCellId, for: indexPath) as? TimelineCell {
            
            // loadDBModel.dataSetsからそれぞれ情報を取得
            let timelineImage = cell.timelineImageView
            timelineImage.loadImage(with: loadDBModel.dataSets[indexPath.row].postImageURLString)
            
            cell.username.text = loadDBModel.dataSets[indexPath.row].username
            
            let profileImage = cell.profileImage
            profileImage.loadImage(with: loadDBModel.dataSets[indexPath.row].profileImageURLString)
            
            cell.dateLabel.text = dateFormatForDateLabel(postDate: loadDBModel.dataSets[indexPath.row].postDate)
            
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
        
        
        
    }
    
    
    func dateFormatForDateLabel(postDate: Timestamp) -> String {
        // 投稿された日付をTimestampからラベル表示用に変換
        let postDateValue = postDate.dateValue()
        let  formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "MM/dd  HH:mm" // 1月1日 12:00
        // String型に変換
        let dateString = formatter.string(from: postDateValue)
        return dateString
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 値を渡して画面遷移
        let selectViewController = SelectViewController()
        selectViewController.username.text = loadDBModel.dataSets[indexPath.row].username
        selectViewController.postImageString = loadDBModel.dataSets[indexPath.row].postImageURLString
        selectViewController.profileImageString = loadDBModel.dataSets[indexPath.row].profileImageURLString
        selectViewController.textView.text = loadDBModel.dataSets[indexPath.row].comment
        selectViewController.userId = loadDBModel.dataSets[indexPath.row].userId
        
        selectViewController.doc = loadDBModel.dataSets[indexPath.row].docId
        
        navigationController?.pushViewController(selectViewController, animated: true)
        
    }
    
    
    
}

extension TimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera()  {
        let sourceType:UIImagePickerController.SourceType = .camera
        // カメラ利用チェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    
    func openLibrary() {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        // フォトライブラリ利用チェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] as? UIImage != nil {
            // 画像をセットして画面遷移
            if let selectedImage = info[.originalImage] as? UIImage {
                postPageViewContorller.postImage = selectedImage
                picker.dismiss(animated: true, completion: nil)
                postPageViewContorller.modalPresentationStyle = .fullScreen
                present(postPageViewContorller, animated: true, completion: nil)
                
            } else {
                return
            }
            
            
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func showAlert() {
        
        let user = Auth.auth().currentUser?.displayName
        
        if user != nil {
            
            let alertController = UIAlertController(title: "新しい投稿を作成します", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "カメラで撮影", style: .default, handler: { action in
                self.openCamera()
            }))
            alertController.addAction(UIAlertAction(title: "ライブラリから選択", style: .default, handler: { action in
                self.openLibrary()
            }))
            alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        } else if user == nil {
            
            let alertController = UIAlertController(title: "確認", message: "投稿機能を利用するにはTwitterアカウントを連携してください", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
}

