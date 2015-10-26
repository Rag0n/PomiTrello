//
//  CardDetailViewController.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import Cartography

class CardDetailViewController: UIViewController {
    
    var card: Card! { didSet { updateUI() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func delete() {
        card.managedObjectContext?.performChanges() {
            self.card.managedObjectContext?.deleteObject(self.card)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: Private
    private func setupView() {
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "delete")
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func updateUI() {
        cardName.text = card.name
    }
    
    
    // MARK: UI
    private lazy var cardName: UILabel = {
        let cardNameLabel = UILabel()
        
        self.view.addSubview(cardNameLabel)
        
        constrain(cardNameLabel, cardNameLabel.superview!, block: { (cardNameLabel, superview) -> () in
            cardNameLabel.centerX == superview.centerX
            cardNameLabel.centerY == superview.centerY
        })
        
        return cardNameLabel
    }()
}