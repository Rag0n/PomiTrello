//
//  TrelloTableViewCell.swift
//  PomiTrello
//
//  Created by Александр on 06.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class TrelloTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
}


extension TrelloTableViewCell: ConfigurableCell {
    func configureForObject(object: Board) {
        label.text = object.name
    }
}