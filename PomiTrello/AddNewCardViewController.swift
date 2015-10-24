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
    @IBOutlet weak var nameTextField: UITextField! { didSet { nameTextField.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "add")
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
        nameTextField.becomeFirstResponder()
    }
    
    func cancel() {
        // presenting view controller ответственнен за dismiss
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func add() {
        guard let name = self.nameTextField.text, let id = self.idLabel.text else {
            return
            // TODO: alert
        }
        managedObjectContext.performChanges() {
            Card.insertIntoContext(self.managedObjectContext, name: name, id: id)
        }
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: TextField Delefate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
