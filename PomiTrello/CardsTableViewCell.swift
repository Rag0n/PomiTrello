//
//  CardsTableViewCell.swift
//  PomiTrello
//
//  Created by Александр on 28.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class CardsTableViewCell: UITableViewCell {
    @IBOutlet weak var cardName: UILabel!
}


extension CardsTableViewCell: ConfigurableCell {
    func configureForObject(object: Card) {
        cardName.text = object.name
    }
}