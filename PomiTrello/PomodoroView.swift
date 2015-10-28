//
//  PomodoroView.swift
//  PomiTrello
//
//  Created by Александр on 28.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class PomodoroView: UIView {
    
    var scale: CGFloat = 0.8 { didSet { setNeedsDisplay() } }
    
    
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
        UIColor.redColor().setStroke()
        path.lineWidth = 3.0
        
        path.stroke()
    }


}
