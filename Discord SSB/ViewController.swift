//
//  ViewController.swift
//  Discord SSB
//
//  Created by Chris Johnson on 8/20/19.
//  Copyright © 2019 Yoeyo, Ltd. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!
    
    let webUrl = "https://discordapp.com/channels/@me"
    let baseDomain = "discordapp.com"
    let webName = "Discord"
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:webUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    
        self.view.window?.title = webName
    }
    
    // Open external links in Safari
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType != .linkActivated {
            // not a click
            decisionHandler(.allow)
            return
        }
        
        let url = navigationAction.request.url
        
        if url?.description.lowercased().range(of: baseDomain) != nil {
            // open in app
            decisionHandler(.allow)
        } else {
            // open in Safari
            decisionHandler(.cancel)
            NSWorkspace.shared.open(url!)
        }
        
    }
    
}
