//
//  TermsOfServiceViewController.swift
//  Leef
//
//  Created by J on 2021/08/18.
//

import UIKit
import WebKit

class TermsOfServiceViewController: UIViewController, WKUIDelegate {
    
    //UI
    let label = UILabel()
    let textView = UITextView()
    var webView: WKWebView!
    
    var color = MainColor()
    
    override func loadView() {
        super.loadView()
        
        configureLabel()
        configureWebView()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color.backColor
        loadURL()
    }
    
    func configureLabel() {
        view.addSubview(label)
        setLabel()
        label.text = "利用規約"
        label.textColor = color.darkGrayColor
        label.font = UIFont(name: "AvenirNext-Bold", size: 17)
        
    }
    
    
    func configureWebView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    func loadURL() {
        let url = URL(string: "https://site-2671642-9203-8355.mystrikingly.com/") //利用規約ページURL
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    
    func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints                                = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive           = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive     = true
    }
    
    func setWebView() {
        webView.translatesAutoresizingMaskIntoConstraints                                           = false
        webView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 70).isActive            = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive        = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive     = true
        
    }
    
}
