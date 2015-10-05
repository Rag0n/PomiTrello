//
//  Board.swift
//  PomiTrello
//
//  Created by Александр on 20.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import CoreData


public final class Board: ManagedObject {
    @NSManaged private(set) var position: Int32
    @NSManaged private(set) var id: String!
    @NSManaged private(set) var name: String!
    @NSManaged private(set) var desc: String!
    @NSManaged private(set) var url: NSURL!
//    @NSManaged private(set) var lists: NSOrderedSet
//    @NSManaged private(set) var lists = [List]()
    
    
    // MARK: - Public API
    
    static func loadBoards(completionHandler: (boards: [Board]) -> Void) throws {
        let key = NSUserDefaults.standardUserDefaults().valueForKey(Constants.queryKey) as! String
        guard let url = NSURL(string: "https://api.trello.com/1/members/me/boards/?filter=open&" + key) else {
            throw Errors.CantLoadBoards
        }
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            // parse JSON
            let boards = Board.parseBoardsJSON(data!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completionHandler(boards: boards)
            })
            
        }
        
        task.resume()
    }
    
//    func loadLists(completionHandler: () -> Void) {
//        let key = NSUserDefaults.standardUserDefaults().valueForKey(Constants.queryKey) as! String
//        let urlText =  "https://api.trello.com/1/boards/" + id + "?lists=open&list_fields=name&fields=name,desc&" + key
//        let url = NSURL(string: urlText)!
//        let request = NSURLRequest(URL: url)
//        let urlSession = NSURLSession.sharedSession()
//        let task = urlSession.dataTaskWithRequest(request) { [unowned self] (data, response, error) -> Void in
//            if error != nil {
//                print(error?.localizedDescription)
//            }
//            
//            self.lists = self.parseListsJSON(data!)
//            
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                completionHandler()
//            })
//        }
//        
//        task.resume()
//    }

    
    // MARK: - Private API
    
    static private func parseBoardsJSON(data: NSData) -> [Board] {
        var boards = [Board]()
        do {
            // get result
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            
            // parse result
            let jsonBoards = jsonResult as! [[String:AnyObject]]
            for jsonBoard in jsonBoards {
                let board = Board()
                board.id = jsonBoard["id"] as! String
                board.name = jsonBoard["name"] as! String
                board.desc = jsonBoard["desc"] as! String
                board.url = NSURL(string: jsonBoard["url"] as! String)
                
                boards.append(board)
            }
        } catch {
            print("Cannot read json result")
        }
        return boards
    }
    
    private func parseListsJSON(data: NSData) -> [List] {
        var newLists = [List]() // полностью обновляем
        
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
                newList.cards = [Card]()
                newLists.append(newList)
            }
        } catch {
            print("Cannot read json result")
        }
        return newLists
    }
}


extension Board: ManagedObjectType {
    public static var entityName: String {
        return "Board"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "position", ascending: false)]
    }
}