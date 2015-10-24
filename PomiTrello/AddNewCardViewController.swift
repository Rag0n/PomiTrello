//
//  CardEditViewController.swift
//  PomiTrello
//
//  Created by Александр on 24.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class AddNewCardViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        nameTextField.becomeFirstResponder()
    }
}
