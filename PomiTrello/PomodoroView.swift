//
//  PomodoroView.swift
//  PomiTrello
//
//  Created by Александр on 28.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

protocol PomodoroDataSource: class {
    var pomodoroTimer: Double { get set }
}

class PomodoroView: UIView {
    
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.redColor() { didSet { setNeedsDisplay() } }
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    
    private var pomodoroCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    private var pomodoroRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
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
