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
    
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    // MARK: Target actions
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
        
        
        view.addSubview(cardName)
        
        pomodoroView.backgroundColor = UIColor.grayColor()
        view.addSubview(pomodoroView)
        
        
        setupConstraints()
    }
    
    private func updateUI() {
        cardName.text = card.name
    }
    
    // MARK: UI
    private var cardName = UILabel()
    private var pomodoroView = PomodoroView()
    
    
    func setupConstraints() {
        let length = self.topLayoutGuide.length // TODO: почему 0?
        let navHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0
        
        constrain(pomodoroView, self.view, cardName, block: { (pomodoroView, view, cardName) -> () in
            let topMarginHeight = navHeight + length + 44
            cardName.topMargin == view.topMargin + topMarginHeight
            cardName.centerX == view.centerX
            
            pomodoroView.topMargin == cardName.bottomMargin + 20
            pomodoroView.centerX == view.centerX
            pomodoroView.width == view.width * 0.8
            pomodoroView.height == 200
        })
    }
}