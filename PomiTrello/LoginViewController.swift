//
//  LoginViewController.swift
//  PomiTrello
//
//  Created by Александр on 20.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UIWebViewDelegate, ManagedObjectContextSettable {

    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var webView: UIWebView!
    private var activityIndicator: UIActivityIndicatorView!
    
    
    private func saveToken(token: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: Constants.userToken)
        defaults.setBool(true, forKey: Constants.hasUserToken)
        configureKey()
//        let ttvc = storyboard!.instantiateViewControllerWithIdentifier(StoryBoard.trelloViewControllerIdentifier) as! TrelloTableViewController
//        ttvc.managedObjectContext = managedObjectContext
//        let navCon = UINavigationController(rootViewController: ttvc)
//        presentViewController(navCon, animated: true, completion: nil)
    }
    
    private func getAppKey() -> String {
        // достаем приватный ключ приложения из property list
        var keys: NSDictionary?
        guard let path = NSBundle.mainBundle().pathForResource("AppKeys", ofType: "plist") else {
            fatalError("App should provide trello api's developer key")
        }
        keys = NSDictionary(contentsOfFile: path)
        
        guard let appKey = keys?[Constants.appKey] as? String else {
            fatalError("App should provide trello api's developer key")
        }
        return appKey
    }
    
    private func configureKey() {
        // создаем и сохраняем ключ, содержащий ключ приложения и пользовательский токен
        // который в дальнейшем будет использоваться для доступа к REST API
        let defaults = NSUserDefaults.standardUserDefaults()
        let appKey = getAppKey()
        guard let token = defaults.objectForKey(Constants.userToken) as? String else {
            fatalError("Cant configure user token")
        }
        let key = "key=\(appKey)&token=\(token)"
        defaults.setObject(key, forKey: Constants.queryKey)
    }
    
    private func configureTokenURL() -> NSURL {
        // создаем url для запроса пользовательского токена
        let urlBegin = "https://trello.com/1/authorize?key="
        let urlEnd = "&name=PomiTrello&expiration=never&response_type=token&scope=read,write"
        
        let appKey = getAppKey()
        let tokenURL = urlBegin + "\(appKey)" + urlEnd
        guard let url = NSURL(string: tokenURL) else {
            fatalError("Cant configure valid user token URL")
        }
        
        return url
    }
    
    private func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.color = UIColor.grayColor()
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator()
        
        // запрашиваем доступ к trello
        let url = configureTokenURL()
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
    
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        if activityIndicator.isAnimating() {
            activityIndicator.stopAnimating()
        }
        // получаем и сохраняем пользовательский токен
        let currentURL: NSString = (webView.request?.URL?.absoluteString)!
        if currentURL == "https://trello.com/1/token/approve" {
            webView.alpha = 0
            // токен находится под тегом pre
            let script = "document.getElementsByTagName('PRE')[0].firstChild.data"
            // получаем и форматируем токен
            if let token = webView.stringByEvaluatingJavaScriptFromString(script)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
                saveToken(token)
            }
        }
    }
}
