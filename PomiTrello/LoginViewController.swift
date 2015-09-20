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
    
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print(request.URL?.absoluteString)
//        page = NSString(st
//        return true
//    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let currentURL : NSString = (webView.request?.URL?.absoluteString)!
        print(currentURL)
        if currentURL == "https://trello.com/1/token/approve" {
            let script = "document.getElementsByTagName('PRE')[0].firstChild.data.replace (/\t+$/, '')"
            if let token = webView.stringByEvaluatingJavaScriptFromString(script)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
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
