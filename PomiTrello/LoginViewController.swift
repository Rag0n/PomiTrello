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
    
    private enum LoginError: ErrorType {
        case CantFindApplicationKey
        case IncorrectTokenURL
    }
    
    private func saveToken(token: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: Constants.userToken)
        defaults.setBool(true, forKey: Constants.hasUserToken)
        configureKey()
        let ttvc = storyboard!.instantiateViewControllerWithIdentifier(StoryBoard.trelloViewControllerIdentifier) as! TrelloTableViewController
        ttvc.managedObjectContext = managedObjectContext
        let navCon = UINavigationController(rootViewController: ttvc)
        presentViewController(navCon, animated: true, completion: nil)
//        self.navigationController?.setViewControllers([ttvc], animated: true)
    }
    
    private func getAppKey() throws -> String {
        // достаем приватный ключ приложения из property list
        var keys: NSDictionary?
        
        guard let path = NSBundle.mainBundle().pathForResource("AppKeys", ofType: "plist") else {
            throw LoginError.CantFindApplicationKey
        }
        keys = NSDictionary(contentsOfFile: path)
        
        if let appKey = keys?[Constants.appKey] as? String {
            return appKey
        }
        return ""
    }
    
    private func configureKey() {
        // создаем и сохраняем ключ, содержащий ключ приложения и пользовательский токен
        // который в дальнейшем будет использоваться для доступа к REST API
        let defaults = NSUserDefaults.standardUserDefaults()
        do {
            let appKey = try getAppKey()
            let token = defaults.objectForKey(Constants.userToken) as? String ?? ""
            let key = "key=\(appKey)&token=\(token)"
            defaults.setObject(key, forKey: Constants.queryKey)
        } catch LoginError.CantFindApplicationKey {
            print("Cant find trello's developer key")
        } catch {
            print("Something went wrong")
        }
    }
    
    private func configureTokenURL() -> NSURL? {
        // создаем url для запроса пользовательского токена
        let urlBegin = "https://trello.com/1/authorize?key="
        let urlEnd = "&name=PomiTrello&expiration=never&response_type=token&scope=read,write"
        
        do {
            let appKey = try getAppKey()
            let tokenURL = urlBegin + "\(appKey)" + urlEnd
            guard let url = NSURL(string: tokenURL) else {
                throw LoginError.IncorrectTokenURL
            }
            return url
        } catch LoginError.CantFindApplicationKey {
            print("Cant find trello's developer key")
        } catch LoginError.IncorrectTokenURL {
            print("Can't configure valid user token URL")
        } catch {
            print("Something went wrong")
        }

        return nil
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.color = UIColor.grayColor()
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        // запрашиваем доступ к trello
        if let url = configureTokenURL() {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
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
