//
//  CardDetailViewController.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    @IBOutlet weak var cardLabel: UILabel!
    var card: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        cardLabel.text = card.name
    }

    func setupView() {
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "delete")
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    func delete() {
        
    }
}