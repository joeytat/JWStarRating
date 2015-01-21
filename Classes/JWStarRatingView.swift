//
//  JWStarRatingView.swift
//  WapaKit
//
//  Created by Joey on 1/21/15.
//  Copyright (c) 2015 Joeytat. All rights reserved.
//

import UIKit

@IBDesignable class JWStarRatingView: UIView {
    
    @IBInspectable var starColor: UIColor = UIColor.rgba(200, g: 200, b: 200, a: 1)
    @IBInspectable var starHighlightColor: UIColor = UIColor.rgba(88, g: 88, b: 88, a: 1)
    
    #if TARGET_INTERFACE_BUILDER
        override func willMoveToSuperview(newSuperview: UIView?) {
        let starRating = JWStarRating(frame: self.bounds, starCount: 5, starColor: self.starColor, starHighlightColor: self.starHighlightColor, spaceBetweenStar: 10)
        self.addSubview(starRating)
    }
    
    #else
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let starRating = JWStarRating(frame: self.bounds, starCount: 5, starColor: self.starColor, starHighlightColor: self.starHighlightColor, spaceBetweenStar: 10)
        starRating.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(starRating)
        
    }
    #endif
    
    func valueChanged(starRating:JWStarRating){
        // Do something with the value...
        println("Value changed \(starRating.ratedStarIndex)")
    }
}
