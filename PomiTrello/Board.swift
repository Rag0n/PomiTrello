//
//  Board.swift
//  PomiTrello
//
//  Created by Александр on 20.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation

class Board {
    var id: String!
    var name: String!
    var description: String!
    var url: NSURL!
    var lists = [List]()
    
    
    // MARK: - Public API
    func loadLists() {
        let key = NSUserDefaults.standardUserDefaults().valueForKey(Constants.queryKey) as! String
        let urlText =  "https://api.trello.com/1/boards/" + id + "?lists=open&list_fields=name&fields=name,desc&" + key
        let url = NSURL(string: urlText)!
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request) { [unowned self] (data, response, error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            self.parseListsJSON(data!)
        }
        
        task.resume()
    }
    
    private func parseListsJSON(data: NSData) {
        do {
            // get result
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            
            // parse result
            let jsonBoard = jsonResult as! [String:AnyObject]
            let lists = jsonBoard["lists"] as! [[String:String]]
            for list in lists {
                let newList = List()
                newList.id = list["id"]!
                newList.name = list["name"]!
                self.lists.append(newList)
            }
        } catch {
            print("Cannot read json result")
        }
    }
}
