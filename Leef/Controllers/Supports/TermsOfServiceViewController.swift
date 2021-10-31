//
//  TermsOfServiceViewController.swift
//  Leef
//
//  Created by J on 2021/08/18.
//

import UIKit
import WebKit

class TermsOfServiceViewController: UIViewController, WKUIDelegate {
    
    // UI
    private var label = UILabel()
    private var  textView = UITextView()
    private var  webView: WKWebView!
    
    private var  color = MainColor()
    private var webURL = URLs()
    private var baseUI = BaseUI()
    
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
    
    private func configureLabel() {
        view.addSubview(label)
        setLabel()
        label.text = "利用規約"
        label.textColor = color.darkGrayColor
        label.font = baseUI.defaultFont(fontSise: 17)
        
    }
    
    
    private func configureWebView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    private func loadURL() {
        guard let url = URL(string: webURL.tosPageURL) else { return } // 利用規約ページURL
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
    private func setLabel() {
        label.translatesAutoresizingMaskIntoConstraints                                = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive           = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive     = true
    }
    
    private func setWebView() {
        webView.translatesAutoresizingMaskIntoConstraints                                           = false
        webView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 70).isActive            = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive        = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive     = true
        
    }
    
}
