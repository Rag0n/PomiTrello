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
            self.parseBoardsJSON(data!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        }
        
        task.resume()
    }
    
    private func parseBoardsJSON(data: NSData) {
        do {
            // get result
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)

            // parse result
            let jsonBoards = jsonResult as! [[String:AnyObject]]
            for jsonBoard in jsonBoards {
                let board = Board()
                board.id = jsonBoard["id"] as! String
                board.name = jsonBoard["name"] as! String
                board.description = jsonBoard["desc"] as! String
                board.url = NSURL(string: jsonBoard["url"] as! String)
                
                self.boards.append(board)
            }
        } catch {
            print("Cannot read json result")
        }
    }
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        key = NSUserDefaults.standardUserDefaults().objectForKey(Constants.queryKey) as? String ?? ""
        print(key)
        do {
            try loadBoards()
        } catch Errors.CantLoadBoards {
            print("Cant load boards")
        } catch {
            print("Something went wrong :(")
        }
        title = "Boards"
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Board cell", forIndexPath: indexPath) as UITableViewCell
        let board = boards[indexPath.row]
        
        cell.textLabel?.text = board.name
        
        return cell
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show list" {
            
        }
    }


}
