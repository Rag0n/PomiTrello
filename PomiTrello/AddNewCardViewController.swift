//
//  CardEditViewController.swift
//  PomiTrello
//
//  Created by Александр on 24.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class AddNewCardViewController: UIViewController, UITextFieldDelegate, ManagedObjectContextSettable {
    
    var managedObjectContext: NSManagedObjectContext!

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "add")
        navigationItem.leftBarButtonItem = closeButton
        nameTextField.becomeFirstResponder()
    }
    
    private func cancel() {
        // presenting view controller ответственнен за dismiss
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func add() {
        managedObjectContext.performChanges() {
            Card.insertIntoContext(self.managedObjectContext, name: self.nameTextField.text!, id: self.idLabel.text!)
        }
    }
    
    // MARK: TextField Delefate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
