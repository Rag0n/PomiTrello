//
//  CardDetailViewController.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData
import Cartography

class CardDetailViewController: UIViewController, PomodoroDataSource, ManagedObjectContextSettable {
    
    var card: Card! { didSet { updateUI() } }
    var managedObjectContext: NSManagedObjectContext!
    var currentPomodoro: Pomodoro!
    
    var pomodoroTimer: Int {
        get {
            return Int(currentPomodoro.time)
        }
    }
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.managedObjectContext.performChanges {
            self.currentPomodoro = Pomodoro.insertIntoContext(self.managedObjectContext, card: self.card)
        }
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
        
        slider.minimumValue = 5
        slider.maximumValue = 60
        slider.value = 25
        view.addSubview(slider)
        
        sliderLabel.text = "\(slider.value)"
        view.addSubview(sliderLabel)
        
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
//        switch state {
//        case .NotStarted:
//            state = .Started
//            // регистрируем нотификашин
//            // начинаем обновлять вью(точнее обновляем pomodoroTimer, а вью сама мониторит обновления)
//        case .Started:
//            state = .Pause
//            // сохраняем состояние помидра
//            // убираем нотификашион
//        case .Pause:
//            // сохраняем состояние помидра
//            // опять регистрируем нотификашион, но уже с оставшимся временем
//        case .Ended:
//            // сохраняем состояние помидра
//            // создаем новый помидор
//        }
        // проверяем текущее состояние
        // если ended - начинаем новый помидор
        // если pause - продолжаем текущий
        print("it works")
    }
    
    // MARK: UI
    private var cardName = UILabel()
    private var pomodoroView = PomodoroView()
    private var slider = UISlider()
    private var sliderLabel = UILabel()
    
    
    func setupConstraints() {
        let length = self.topLayoutGuide.length // TODO: почему 0?
        let navHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0
        
        constrain(pomodoroView, self.view, cardName, block: { (pomodoroView, view, cardName) -> () in
            let topMarginHeight = navHeight + length + 44
            cardName.topMargin == view.topMargin + topMarginHeight
            cardName.centerX == view.centerX
            
            pomodoroView.topMargin == cardName.bottomMargin + 30
            pomodoroView.centerX == view.centerX
            pomodoroView.width == view.width * 0.7
            pomodoroView.height == 200
        })
        
        constrain(pomodoroView, slider, sliderLabel) { (pomodoroView, slider, sliderLabel) -> () in
            sliderLabel.topMargin == pomodoroView.bottomMargin + 30
            sliderLabel.centerX == slider.superview!.centerX
            
            slider.topMargin == sliderLabel.bottomMargin + 20
            slider.centerX == slider.superview!.centerX
            slider.width == pomodoroView.width
        }
    }
}