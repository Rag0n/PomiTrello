//
//  PomodoroViewController.swift
//  PomiTrello
//
//  Created by Александр on 28.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class PomodoroViewController: UIViewController {

    @IBOutlet weak var cardLabel: UILabel!
    var card: Card!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardLabel.text = card.name
    }

}
