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
    
    // UI
    private var tableView = UITableView()
    private var titleImage = UIImageView()
    
    private let timelineCellId = "timelineCell"
    
    public var postPageViewContorller = PostPageViewController()
    public var checkPermission = CheckPermission()
    private var color = MainColor()
    private var loadDBModel = LoadDBModel()
    
    
    override func loadView() {
        super.loadView()
        configureNav()
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        super.viewDidAppear(animated)
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
    private func configureNav() {
        // navigationBarを表示
        navigationController?.setNavigationBarHidden(false, animated: true)
        // rightBarButtonItem(投稿作成)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        // titleに画像をセット
        let image = #imageLiteral(resourceName: "navigationBarTitleImage")
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
    
    
    
    @objc
    private func toNewPostPage() {
        // 新規投稿作成ページに遷移
        let postPageViewController = PostPageViewController()
        postPageViewController.modalPresentationStyle = .fullScreen
        present(postPageViewController, animated: true, completion: nil)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TimelineCell.self, forCellReuseIdentifier: timelineCellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = color.backColor
        setTableView()
        
    }
    
    private func setTableView() {
        configureRefreshControl()
        tableView.pin(to: view)
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
    
    
    private func dateFormatForDateLabel(postDate: Timestamp) -> String {
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
