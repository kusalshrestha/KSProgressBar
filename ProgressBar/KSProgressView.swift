//
//  KSProgressView.swift
//  ProgressBar
//
//  Created by Kusal Shrestha on 1/25/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

class KSProgressView: UIView {

    var steps: [KSStep] = []
    var lineWidth: CGFloat!
    var numberOfSteps: Int! {
        didSet {
            designProgressView()
        }
    }
    private var progressColor: UIColor!
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.progressColor = color
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rePositionSteps()
    }
    
    private func designProgressView() {
        for iterator in 0..<numberOfSteps {
            let step = KSStep(color: self.progressColor)
            step.stepNumber = iterator
            self.addSubview(step)
            steps.append(step)
        }
        steps.last?.isLastStep = true
    }
    
    func setProgress(progress: Int) {
        guard progress > 0 && progress <= numberOfSteps else {
            return
        }
        
        guard progress != 1 else {
            UIView.animateWithDuration(0.5, animations: { _ in
                self.steps.first?.animateStep()
                }, completion: nil)
            return
        }
        
        // completed circle
        for iterator in 0..<(progress - 1) {
            steps[iterator].completedCircularStep()
        }
        
        //completed line
        if progress >= 3 {
            for iterator in 0..<(progress - 2) {
                steps[iterator].completedLine()
            }
        }
        self.steps[progress - 2].animateLine({ (completed) -> Void in
            if completed {
                self.steps[progress - 1].animateStep()
            }
            }, lineWidth: lineWidth)

    }
    
    private func rePositionSteps() {
        for iterator in 0..<numberOfSteps {
            let step = steps[iterator]
            step.center = getPositionForStepAtIndex(iterator)
            step.backLineLayer.frame = dynamicChangeLineWidth(iterator, maxX: CGRectGetMaxX(step.bounds) + lineHeight / 2, midY: CGRectGetMidY(step.bounds) + 2)
            step.frontLineLayer.frame = dynamicChangeLineWidth(iterator, maxX: CGRectGetMaxX(step.bounds) + lineHeight / 2, midY: CGRectGetMidY(step.bounds) + 2)
            step.frontLineLayer.anchorPoint = CGPointZero
        }
    }
    
    private func getPositionForStepAtIndex(index: Int) -> CGPoint {
        let xPos = circleRadius + (self.bounds.width - CGFloat(2 * circleRadius)) / CGFloat(numberOfSteps - 1) * CGFloat(index)
        let yPos = self.bounds.height / 2
        return CGPoint(x: xPos, y: yPos)
    }
    
    private func dynamicChangeLineWidth(index: Int, maxX: CGFloat, midY: CGFloat) -> CGRect {
        lineWidth = (self.bounds.width - CGFloat(24 * numberOfSteps)) / CGFloat(numberOfSteps - 1)
        return CGRect(origin: CGPoint(x: maxX, y: -midY), size: CGSize(width: lineWidth + 1, height: lineHeight))
    }
    
}
