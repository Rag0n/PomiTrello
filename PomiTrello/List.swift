//
//  List.swift
//  PomiTrello
//
//  Created by Александр on 26.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation


class List {
    var id: String!
    var name: String!
    var cards: [Card]!
    
    func loadCards(completionHandler: () -> Void) {
        let key = NSUserDefaults.standardUserDefaults().valueForKey(Constants.queryKey) as! String
        let urlText =  "https://api.trello.com/1/lists/" + id + "?fields=name&cards=open&card_fields=name&" + key
        let url = NSURL(string: urlText)!
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            self.parseCardsJSON(data!)
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completionHandler()
            })
        }
        
        task.resume()
    }
    
    private func parseCardsJSON(data: NSData) {
        var newCards = [Card]() // полностью обновляем
        
        do {
            // get result
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            
            // parse result
            let jsonBoard = jsonResult as! [String:AnyObject]
            let cards = jsonBoard["cards"] as! [[String:String]]
            for card in cards {
                let newCard = Card()
                newCard.id = card["id"]!
                newCard.name = card["name"]!
                newCards.append(newCard)
            }
        } catch {
            print("Cannot read json result")
        }
        cards = newCards
    }
}