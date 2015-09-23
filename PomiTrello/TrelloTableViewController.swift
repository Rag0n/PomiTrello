//
//  TrelloTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class TrelloTableViewController: UITableViewController {
    // MARK: - Model
    var boards = [Board]()
    
    // MARK: - Private API
    private var key: String!
    
    enum Errors: ErrorType {
        case CantLoadBoards
    }
    
    private func loadBoards() throws {
        guard let url = NSURL(string: APIConstants.openBoards + key) else {
            throw Errors.CantLoadBoards
        }
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request) { [unowned self] (data, response, error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            // parse JSON
            self.boards = self.parseBoardsJSON(data!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        }
    }
    
    private func parseBoardsJSON(data: NSData) -> [Board] {
        var boards = [Board]()
        
        // get result
        do {
            // get result
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            // parse result
            let jsonBoards = jsonResult as! [AnyObject]
            for jsonBoard in jsonBoards {
                if jsonBoard["closed"] as! Bool == true {
                    continue
                }
                let board = Board()
                board.id = jsonBoard["id"] as! String
                board.name = jsonBoard["name"] as! String
                board.description = jsonBoard["description"] as! String
                board.url = NSURL(string: jsonBoard["url"] as! String)
                boards.append(board)
            }
        } catch {
            print("Cannot read json result")
        }
        
        // parse result

        
        return boards
    }
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        key = NSUserDefaults.standardUserDefaults().objectForKey(Constants.queryKey) as? String ?? ""
        print(key)
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
