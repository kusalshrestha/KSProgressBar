//
//  KSStep.swift
//  ProgressBar
//
//  Created by Kusal Shrestha on 1/25/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import Foundation
import UIKit

let circleSize = CGSize(width: 20, height: 20)
let insideCircleSize = CGSize(width: 10, height: 10)
let circleRadius: CGFloat = 12
let lineHeight: CGFloat = 4

class KSStep: UIView {
    
    private var backCircleShape = CAShapeLayer()
    private var backInnerCircleShape = CAShapeLayer()
    private var backLineShape = CAShapeLayer()
    
    private var frontCircleShape = CAShapeLayer()
    private var frontInnerCircleShape = CAShapeLayer()
    private var frontLineShape = CAShapeLayer()
    private var progressColor = UIColor.redColor()
    
    var backLineLayer: CAShapeLayer {
        return backLineShape
    }
    
    var frontLineLayer: CAShapeLayer {
        return frontLineShape
    }
    
    var isLastStep = false {
        didSet {
            if isLastStep {
                frontLineShape.hidden = true
                backLineShape.hidden = true
            }
        }
    }
    var stepNumber: Int!
    
    convenience init(color: UIColor) {
        self.init(frame: CGRect(origin: CGPointZero, size: circleSize))
        self.progressColor = color
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        designProgressViewBackLayer(UIColor.grayColor()) //back layer
        designProgressViewFrontLayer(UIColor.clearColor()) //front layer
    }
    
    private func designProgressViewBackLayer(color: UIColor) {
        designStep(backCircleShape, color: color)
        designInsideStep(backInnerCircleShape, color: color)
        drawLines(backLineShape, color: color)
    }
    
    private func designProgressViewFrontLayer(color: UIColor) {
        designStep(frontCircleShape, color: color)
        designInsideStep(frontInnerCircleShape, color: color)
        drawLines(frontLineShape, color: color)
    }
    
    private func designStep(circleShape: CAShapeLayer, color: UIColor) {
        circleShape.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1)
        let bezierPath = UIBezierPath(roundedRect: CGRect(origin: CGPointZero, size: circleSize), cornerRadius: circleSize.width / 2)
        circleShape.path = bezierPath.CGPath
        circleShape.strokeColor = color.CGColor
        circleShape.lineWidth = lineHeight
        circleShape.fillColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(circleShape)
    }
    
    private func designInsideStep(insideCircleShape: CAShapeLayer, color: UIColor) {
        insideCircleShape.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1)
        let bezierPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: (circleSize.width - insideCircleSize.width) / 2, y: (circleSize.width - insideCircleSize.width) / 2), size: insideCircleSize), cornerRadius: insideCircleSize.width / 2)
        insideCircleShape.path = bezierPath.CGPath
        insideCircleShape.fillColor = color.CGColor
        self.layer.addSublayer(insideCircleShape)
        insideCircleShape.anchorPoint = CGPoint(x: (circleSize.width - insideCircleSize.width) / 2, y: (circleSize.width - insideCircleSize.width) / 2)
    }
    
    func animateStep() {
        self.frontCircleShape.strokeColor = self.progressColor.CGColor
        self.frontCircleShape.animateWithDuration(0.5, keypath: "strokeEnd", animation: { (anim) in
            anim.fromValue = 0
            anim.toValue = 1
            }) { _ in
                self.frontInnerCircleShape.fillColor = self.progressColor.CGColor
                self.frontInnerCircleShape.animateWithDuration(0.5, keypath: "fillColor", animation: { (anim) in
                    anim.fromValue = UIColor.grayColor().CGColor
                    anim.toValue = self.progressColor.CGColor
                    }, completion: {
                        self.frontInnerCircleShape.fillColor = self.progressColor.CGColor
                })
        }
    }
    
    func animateLine(animationCompletion: ((Bool) -> Void)?, lineWidth: CGFloat) {
        self.frontLineShape.backgroundColor = self.progressColor.CGColor
        self.frontLineShape.bounds = CGRect(origin: CGPointZero, size: CGSize(width: lineWidth, height: lineHeight))
        self.frontLineShape.animateWithDuration(0.5, keypath: "bounds", animation: { (anim) in
            anim.fromValue = NSValue(CGRect: CGRect(origin: CGPointZero, size: CGSize(width: 0, height: lineHeight)))
            anim.toValue = NSValue(CGRect: CGRect(origin: CGPointZero, size: CGSize(width: lineWidth, height: lineHeight)))
            }) { _ in
                self.frontLineShape.bounds = CGRect(origin: CGPointZero, size: CGSize(width: lineWidth, height: lineHeight))
                animationCompletion!(true)
        }
    }
    
    func completedCircularStep() {
        frontCircleShape.strokeColor = self.progressColor.CGColor
        frontInnerCircleShape.fillColor = self.progressColor.CGColor
    }
    
    func completedLine() {
        frontLineShape.backgroundColor = self.progressColor.CGColor
    }
    
    private func drawLines(lineShape: CAShapeLayer, color: UIColor) {
        lineShape.backgroundColor = color.CGColor
        self.layer.addSublayer(lineShape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
