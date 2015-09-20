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
        static var tokenURL = "https://trello.com/1/authorize?key=98fe09a86250735e1462a019ad4087b3&name=PomiTrello&expiration=never&response_type=token"
        static var userToken = "userToken"
    }
    
    private func saveToken(token: String) {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: Constants.userToken)
        presentViewController(TrelloTableViewController(), animated: true, completion: nil)s
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
        let currentURL : NSString = (webView.request?.URL?.absoluteString)!
//        print(currentURL)
        if currentURL == "https://trello.com/1/token/approve" {
            let script = "document.getElementsByTagName('PRE')[0].firstChild.data.replace (/\t+$/, '')"
            if let token = webView.stringByEvaluatingJavaScriptFromString(script)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
                saveToken(token)
                print(token)
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
