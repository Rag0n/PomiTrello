//
//  Constants.swift
//  PomiTrello
//
//  Created by Александр on 20.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation


struct Constants {
    static var appKey = "AppKey"
    static var hasUserToken = "hasUserToken"
    static var userToken = "userToken"
    static var tokenURL = "https://trello.com/1/authorize?key=98fe09a86250735e1462a019ad4087b3&name=PomiTrello&expiration=never&response_type=token&scope=read,write"
    static var queryKey = "QueryKey" // используется для всех запросов
    
    static var baseURL = "https://api.trello.com/1/"
}

struct StoryBoard {
    static var welcomeViewControllerIdentifier = "WelcomeViewController"
    static var loginViewControllerIdentifier = "LoginViewController"
    static var trelloViewControllerIdentifier = "MainViewController"
}

enum Errors: ErrorType {
    case CantLoadBoards
}
