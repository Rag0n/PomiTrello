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
    private var pomodoroView = UIView()
    
//    private lazy var cardName: UILabel = {
//        let cardNameLabel = UILabel()
//        
//        self.view.addSubview(cardNameLabel)
//        
//        constrain(cardNameLabel, cardNameLabel.superview!, block: { (cardNameLabel, superview) -> () in
//            cardNameLabel.centerX == superview.centerX
//            cardNameLabel.centerY == superview.centerY
//        })
//        
//        return cardNameLabel
//    }()
    
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