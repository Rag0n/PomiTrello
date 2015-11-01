//
//  PomodoroView.swift
//  PomiTrello
//
//  Created by Александр on 28.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

protocol PomodoroDataSource: class {
    var pomodoroTimer: Int { get }
}

class PomodoroView: UIView {
    
    var scale: CGFloat = 1 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.redColor() { didSet { setNeedsDisplay() } }
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    weak var dataSource: PomodoroDataSource?
    
    private var pomodoroCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    private var pomodoroRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale - lineWidth
    }

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.addArcWithCenter(pomodoroCenter, radius: pomodoroRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        path.closePath()
        
        color.set()
        path.lineWidth = lineWidth
        
        path.stroke()
    }


}
