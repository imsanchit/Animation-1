//
//  DrawView.swift
//  Animation 1
//
//  Created by Sanchit Mittal on 04/10/17.
//  Copyright © 2017 Sanchit Mittal. All rights reserved.
//

import UIKit

@IBDesignable
class DrawView: UIView {
    var colorPath: UIBezierPath? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var paths: [UIBezierPath]?
    var centre: CGPoint = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    
    @IBInspectable
    var radius: CGFloat = 100 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var numberOfSections: Int = 6 { didSet { setNeedsDisplay() } }

    @IBInspectable
    var lineWidth: CGFloat = 5 { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        paths?.removeAll()
        var startAngle: CGFloat = 0
        while startAngle < CGFloat(2*Double.pi) {
            let path = definePath(startAngle: &startAngle)
            paths?.append(path)
            path.stroke()
            colorCircleIn(path: path)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        checkTouchInCircle(touch: touch!)
    }
    
    
    func definePath(startAngle: inout CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.addArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: startAngle + (CGFloat(2*Double.pi) / CGFloat(numberOfSections)), clockwise: true)
        startAngle = startAngle + CGFloat(2*Double.pi) / CGFloat(numberOfSections)
        path.addLine(to: centre)
        path.close()
        return path
    }
    
    func colorCircleIn(path: UIBezierPath) {
        if path == colorPath {
            UIColor.red.setFill()
            path.fill()
        }
    }
    
    func checkTouchInCircle(touch: UITouch) {
        var startAngle: CGFloat = 0
        while startAngle < CGFloat(2*Double.pi) {
            let path = definePath(startAngle: &startAngle)
            if path.contains((touch.location(in: self))) {
                colorPath = path
                setNeedsDisplay()
                return
            }
        }
    }
//    func startAnimation() {
//        colorPath = paths?[2]
//    }
}
