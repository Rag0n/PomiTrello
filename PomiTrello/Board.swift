//
//  Board.swift
//  PomiTrello
//
//  Created by Александр on 20.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation

class Board {
    var name: String!
    var description: String!
    var closed: Bool!
    var url: NSURL!
    var lists = [List]()
    
    enum Errors: ErrorType {
        case CantLoadBoards
    }
    
    // MARK: - Public API
    static func loadBoards() throws -> [Board] {
        guard let key = NSUserDefaults.standardUserDefaults().objectForKey(Constants.queryKey) as? String else {
            throw Errors.CantLoadBoards
        }
        guard let url = NSURL(string: APIConstants.openBoards + key) else {
            throw Errors.CantLoadBoards
        }
        let request = NSURLRequest(URL: url)
        
        return [Board]()
    }
}
