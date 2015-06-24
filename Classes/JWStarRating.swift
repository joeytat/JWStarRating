//
//  JWStarRating.swift
//  WapaKit
//
//  Created by Joey on 1/21/15.
//  Copyright (c) 2015 Joeytat. All rights reserved.
//

import UIKit

class JWStarRating: UIControl {
    var spaceBetweenStar: CGFloat = 10
    var starCount: Int = 5
    var starColor: UIColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1)
    var starHighlightColor: UIColor = UIColor(red: 88.0/255.0, green: 88.0/255.0, blue: 88.0/255.0, alpha: 1)
    
    var ratedStarIndex: Int = 3{
        didSet{
            setNeedsDisplay()
        }
    }

    var starLocation: Array<CGFloat> = Array()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, starCount: Int, starColor: UIColor, starHighlightColor: UIColor, spaceBetweenStar: CGFloat) {
        self.init(frame: frame)
        self.starCount = starCount
        self.starColor = starColor
        self.starHighlightColor = starHighlightColor
        self.spaceBetweenStar = spaceBetweenStar
    }
    
    /**
    Star's drawing code is based on the [Zaph's answer](http://stackoverflow.com/a/8446655/4251613)
    
    :param: rect CGRect
    */
    override func drawRect(rect: CGRect) {
        
        starLocation.removeAll(keepCapacity: true)
        let starSize = rect.width / CGFloat(starCount) - spaceBetweenStar * 2
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, rect.width)
        var xCenter: CGFloat = starSize / 2 + spaceBetweenStar * 1.5
        let yCenter: CGFloat = rect.height / 2
        
        let r: CGFloat = starSize / 2.0
        let flip: CGFloat = -1.0
        
        for i in 0...Int(starCount-1) {
            
            if i > ratedStarIndex-1 {
                CGContextSetFillColorWithColor(context, starColor.CGColor)
                CGContextSetStrokeColorWithColor(context, starColor.CGColor)
            }else {
                CGContextSetFillColorWithColor(context, starHighlightColor.CGColor)
                CGContextSetStrokeColorWithColor(context, starHighlightColor.CGColor)
            }
            let theta: CGFloat = CGFloat(2.0) * CGFloat(M_PI) * (CGFloat(2.0) / CGFloat(5.0)) // 114 degree
            
            CGContextMoveToPoint(context, xCenter, r*flip+yCenter)
            
            for k in 0...5 {
                let x: CGFloat = r * sin(CGFloat(k) * theta)
                let y: CGFloat = r * cos(CGFloat(k) * theta)
                CGContextAddLineToPoint(context, x+xCenter, y*flip+yCenter)
                let starXCenter = x+xCenter
            }
            starLocation.append(xCenter)
            xCenter += starSize + spaceBetweenStar * 1.5
            CGContextClosePath(context)
            CGContextFillPath(context)
            
        }
    }
    
    /**
    Check the touch point whether or not in the stars frame. If it is redraw.
    
    :param: point Touch point
    */
    private func hitStar(point: CGPoint) {
        let starSize = self.bounds.width / CGFloat(starCount) - spaceBetweenStar * 2
        for var i = 0; i < starLocation.count; i++ {
            let starXCenter = starLocation[i]
            if (point.x > starXCenter - starSize / 2) && (point.x < starXCenter + starSize / 2) {
                ratedStarIndex = i + 1
                break
            }
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        let lastPoint = touch.locationInView(self)
        hitStar(lastPoint)
        sendActionsForControlEvents(.ValueChanged)
        return true
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        let touch = touches.first as! UITouch
        let lastPoint = touch.locationInView(self)
        hitStar(lastPoint)
        sendActionsForControlEvents(.ValueChanged)
    }
    
}
