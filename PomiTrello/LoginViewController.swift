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
    private var presentViewController: UIViewController!
    
    // MARK: - Private API
    private enum LoginError: ErrorType {
        case CantFindApplicationKey
        case IncorrectTokenURL
    }
    
    private func saveToken(token: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: Constants.userToken)
        defaults.setBool(true, forKey: Constants.hasToken)
        configureKey()
        let ttvc = storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! TrelloTableViewController
        self.navigationController?.setViewControllers([ttvc], animated: true)
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
        if let url = configureTokenURL() {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }
    
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        // получаем и сохраняем пользовательский токен
        let currentURL: NSString = (webView.request?.URL?.absoluteString)!
        if currentURL == "https://trello.com/1/token/approve" {
            // токен находится под тегом pre
            let script = "document.getElementsByTagName('PRE')[0].firstChild.data"
            // получаем и форматируем токен
            if let token = webView.stringByEvaluatingJavaScriptFromString(script)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
                saveToken(token)
            }
        }
    }
}
