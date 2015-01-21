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
    var starColor: UIColor = UIColor.rgba(200, g: 200, b: 200, a: 1)
    var starHighlightColor: UIColor = UIColor.rgba(88, g: 88, b: 88, a: 1)
    
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
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        return true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        let touch = touches.anyObject() as UITouch
        let lastPoint = touch.locationInView(self)
        hitStar(lastPoint)
    }
    
}
