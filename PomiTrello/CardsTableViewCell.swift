//
//  CardsTableViewCell.swift
//  PomiTrello
//
//  Created by Александр on 28.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    // Public API
    var card: Card? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        cardName.text = card!.name
    }

    @IBOutlet weak var cardName: UILabel!
}


extension CardsTableViewCell: ConfigurableCell {
    func configureForObject(object: Card) {
        
    }
}