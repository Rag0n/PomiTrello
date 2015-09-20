//
//  LoginViewController.swift
//  PomiTrello
//
//  Created by Александр on 20.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Private API
    
    private struct Constants {
        static var tokenURL = "https://trello.com/1/authorize?key=98fe09a86250735e1462a019ad4087b3&name=PomiTrello&expiration=never&response_type=token&scope=read,write"
        static var userToken = "userToken"
        static var hasToken = "HasToken"
    }
    
    private func saveToken(token: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: Constants.userToken)
        defaults.setBool(true, forKey: Constants.hasToken)
        presentViewController(TrelloTableViewController(), animated: true, completion: nil)
    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: Constants.tokenURL) {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }
    
    
    // MARK: - UIWebViewDelegate
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let currentURL: NSString = (webView.request?.URL?.absoluteString)!
        if currentURL == "https://trello.com/1/token/approve" {
            // токен находится под тегом pre
            let script = "document.getElementsByTagName('PRE')[0].firstChild.data.replace (/\t+$/, '')"
            if let token = webView.stringByEvaluatingJavaScriptFromString(script)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
                saveToken(token)
//                print(token)
            }
        }
    }
}
