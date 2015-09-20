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
    
    private func saveToken(token: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: Constants.userToken)
        defaults.setBool(true, forKey: Constants.hasToken)
        presentViewController(TrelloTableViewController(), animated: true, completion: nil)
    }
    
    private func getAppKey() -> String {
        // получаем приватный ключ приложения из файла Keys.plist
        var keys: NSDictionary?
        
        if let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            if let appKey = dict[Constants.appKey] as? String {
                return appKey
            }
        }
        return ""
    }
    
    private func configureKey() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let appKey = getAppKey()
        let token = defaults.objectForKey(Constants.userToken) as? String ?? ""
        let key = "key=\(appKey)&token=\(token)"
        defaults.setObject(key, forKey: Constants.queryKey)
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
            }
        }
    }
}
