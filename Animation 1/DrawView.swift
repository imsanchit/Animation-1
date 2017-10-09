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
    
    var selectedSegmentIndex: Int? {
        didSet {
            setNeedsDisplay()
        }
    }
    let animation = CABasicAnimation(keyPath: "position")

    private var centre: CGPoint = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    private var doAnimation = false
    
    @IBInspectable
    var radius: CGFloat = 100 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var numberOfSections: Int = 12 { didSet { setNeedsDisplay() } }
    
    private var spinLayer: CAShapeLayer? = nil

    private var eachSegmentAngle: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        eachSegmentAngle = CGFloat(2*Double.pi) / CGFloat(numberOfSections)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        findSelectedSegmentFor(touch: touch!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        findSelectedSegmentFor(touch: touch!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedSegmentIndex = nil
    }

    override func draw(_ rect: CGRect) {
        for index in 0 ..< numberOfSections {
            let startAngle = CGFloat(index) * eachSegmentAngle
            definePath(startAngle: startAngle, index: index)
        }
    }

    func startAnimation() {
        
        guard !doAnimation else {
            return
        }
        doAnimation = true
        
        spinLayer = CAShapeLayer()
        spinLayer?.path = createPathForAnimation().cgPath
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.byValue = 3 * eachSegmentAngle
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        spinLayer?.repeatCount = 1
//        spinLayer?.duration = 5
        
        spinLayer?.fillColor = UIColor.green.cgColor
        spinLayer?.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: radius, height: radius))
        spinLayer?.position = centre
        spinLayer?.anchorPoint = CGPoint.zero
        spinLayer?.add(rotation, forKey: "rotation")
        layer.addSublayer(spinLayer!)
    }
    
    func stopAnimation() {
        spinLayer?.removeAllAnimations()
        doAnimation = false
        spinLayer?.removeFromSuperlayer()
    }
    
    
    
    
    func createPathForAnimation() -> UIBezierPath {
        let startAngle: CGFloat = 0
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: startAngle + eachSegmentAngle, clockwise: true)
        path.addLine(to: CGPoint.zero)
        path.close()
        UIColor.red.setFill()
        path.fill()
        return path
    }
    
    func definePath(startAngle: CGFloat, index: Int) {
        let path = UIBezierPath()
        path.addArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: startAngle + eachSegmentAngle, clockwise: true)
        let firstPointOfSegment = path.currentPoint
        path.addLine(to: centre)
        path.close()
        
        if selectedSegmentIndex == index {
            UIColor.red.setFill()
        } else {
            UIColor.clear.setFill()
        }
        path.fill()
        let secondPointOfSegment = path.currentPoint
        let label = createLabelForSegment(index: index, firstPointOfSegment: firstPointOfSegment, secondPointOfSegment: secondPointOfSegment)
        addSubview(label)
        
        path.stroke()
    }
    

    func createLabelForSegment(index: Int, firstPointOfSegment: CGPoint, secondPointOfSegment: CGPoint) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        var midPoint = CGPoint(x: (firstPointOfSegment.x + secondPointOfSegment.x)/2, y: (firstPointOfSegment.y + secondPointOfSegment.y)/2)
        midPoint.x = (midPoint.x + centre.x) / 2
        midPoint.y = (midPoint.y + centre.y) / 2
        
        label.center = midPoint
        label.textAlignment = .left
        label.text = String(index)
        return label
    }
    
    func findSelectedSegmentFor(touch: UITouch) {
        let startingPoint: CGPoint = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        let endingPoint: CGPoint = (touch.location(in: self))
        let xDist = startingPoint.x - endingPoint.x
        let yDist = startingPoint.y - endingPoint.y
        let distance = CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
        guard distance <= radius else {
            return
        }
        let radians: Float = atan2f(Float(endingPoint.y - startingPoint.y), Float(endingPoint.x - startingPoint.x))
        var degrees: Float = radians * Float(180.0 / .pi)
        degrees = degrees > 0.0 ? degrees : (360.0 + degrees)
        let eachAngle: Float = Float(360 / numberOfSections)
        selectedSegmentIndex = Int(degrees / eachAngle)
    }
}
