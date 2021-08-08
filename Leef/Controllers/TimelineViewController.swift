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
import Nuke


class TimelineViewController: UIViewController, LoadDelegate {

    let postPageViewContorller = PostPageViewController()
    let checkPermission = CheckPermission()
    let color = MainColor()
    let loadDBModel =  LoadDBModel()
    
    //UI
    let tableView = UITableView()
    let timelineCellId = "timelineCell"
    

       
    override func loadView() {
        super.loadView()
    
        configureNav()
        configureTableView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        //全体のPosDataをロード
        loadDBModel.loadPostData()
        tableView.reloadData()
        
        loadDBModel.loadDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        checkPermission.showCheckPermission()
        
 }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("viewWillAppear")
        tableView.reloadData()
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    func doneLoad(check: Int) {
        //ロード処理が完了したらreloadDataを実行
        if check == 1 {
            tableView.reloadData()
        }
    }

    func configureNav() {
        navigationItem.title = "タイムライン"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = color.backColor
        navigationController?.navigationBar.tintColor = color.darkGrayColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: color.darkGrayColor]
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        navigationItem.hidesBackButton = true
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

    
    @objc func toNewPostPage() {
        //新規投稿作成ページに遷移
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
   
        let cell = tableView.dequeueReusableCell(withIdentifier: timelineCellId, for: indexPath) as! TimelineCell
    
        //loadDBModel.dataSetsからそれぞれ情報を取得
        let timelineImage = cell.timelineImageView
        timelineImage.loadImage(with: loadDBModel.dataSets[indexPath.row].postImageURLString)
        
        cell.username.text = loadDBModel.dataSets[indexPath.row].username
        
        let profileImage = cell.profileImage
        profileImage.loadImage(with: loadDBModel.dataSets[indexPath.row].profileImageURLString)
        
        cell.dateLabel.text = dateFormatForDateLabel(postDate: loadDBModel.dataSets[indexPath.row].postDate)
        
        cell.selectionStyle = .none
     
        return cell

    }

    
    func dateFormatForDateLabel(postDate: Timestamp) -> String {
        //投稿された日付をTimestampからラベル表示用に変換
        let postDateValue =  postDate.dateValue()
        let  formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "MM/dd  HH:mm" //1月1日 12:00
        //String型に変換
        let dateString = formatter.string(from: postDateValue)
        return dateString
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped cell")
     
        //値を渡して画面遷移
        let selectViewController = SelectViewController()
        selectViewController.username.text = loadDBModel.dataSets[indexPath.row].username
        selectViewController.postImageString = loadDBModel.dataSets[indexPath.row].postImageURLString
        selectViewController.profileImageString = loadDBModel.dataSets[indexPath.row].profileImageURLString
        selectViewController.textView.text = loadDBModel.dataSets[indexPath.row].comment
        selectViewController.userId = loadDBModel.dataSets[indexPath.row].userId
        
        navigationController?.pushViewController(selectViewController, animated: true)

    }
    

    
}

extension TimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera(){
        let sourceType:UIImagePickerController.SourceType = .camera
        //カメラ利用チェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    
    func openLibrary(){
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        //フォトライブラリ利用チェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] as? UIImage != nil{
            //画像をセットして画面遷移
            let selectedImage = info[.originalImage] as! UIImage
            postPageViewContorller.postImage = selectedImage
            picker.dismiss(animated: true, completion: nil)
            postPageViewContorller.modalPresentationStyle = .fullScreen
            present(postPageViewContorller, animated: true, completion: nil)
           
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func showAlert(){
        let alertController = UIAlertController(title: "新しい投稿を作成します", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "カメラで撮影", style: .default, handler: { action in
            self.openCamera()
        }))
        alertController.addAction(UIAlertAction(title: "ライブラリから選択", style: .default, handler: { action in
            self.openLibrary()
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

