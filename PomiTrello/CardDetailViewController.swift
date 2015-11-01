//
//  CardDetailViewController.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import Cartography

class CardDetailViewController: UIViewController, PomodoroDataSource {
    
    var card: Card! { didSet { updateUI() } }
    
    var pomodoroTimer: Double {
        get {
            // в секундах
            return 1500
        }
    }
    
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
    private var state: CurrentState = .NotStarted
    
    private enum CurrentState {
        case NotStarted
        case Started
        case Pause
        case Ended
    }
    
    private func setupView() {
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "delete")
        navigationItem.rightBarButtonItem = deleteButton
        
        view.addSubview(cardName)
        configurePomodoroView()
        
        setupConstraints()
    }
    
    private func configurePomodoroView() {
        pomodoroView.backgroundColor = UIColor.grayColor()
        pomodoroView.dataSource = self
        pomodoroView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "changePomodoroState:"))
        view.addSubview(pomodoroView)
    }
    
    private func updateUI() {
        cardName.text = card.name
    }
    
    
    // MARK: Gesture Handlers
    func changePomodoroState(gesture: UITapGestureRecognizer) {
        switch state {
        case .NotStarted:
            state = .Started
            // регистрируем нотификашин
            // начинаем обновлять вью(точнее обновляем pomodoroTimer, а вью сама мониторит обновления)
        case .Started:
            state = .Pause
            // убираем нотификашион
        case .Pause:
            // опять регистрируем нотификашион, но уже с оставшимся временем
        case .Ended:
            // создаем новый помидор
        }
        // проверяем текущее состояние
        // если ended - начинаем новый помидор
        // если pause - продолжаем текущий
        print("it works")
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