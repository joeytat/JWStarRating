//
//  JWStarRatingView.swift
//  WapaKit
//
//  Created by Joey on 1/21/15.
//  Copyright (c) 2015 Joeytat. All rights reserved.
//

import UIKit

@IBDesignable class JWStarRatingView: UIView {
    
    @IBInspectable var starColor: UIColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1)
    @IBInspectable var starHighlightColor: UIColor = UIColor(red: 88.0/255.0, green: 88.0/255.0, blue: 88.0/255.0, alpha: 1)
    @IBInspectable var starCount:Int = 5
    @IBInspectable var spaceBetweenStar:CGFloat = 10.0
    
    #if TARGET_INTERFACE_BUILDER
        override func willMoveToSuperview(newSuperview: UIView?) {
        let starRating = JWStarRating(frame: self.bounds, starCount: self.starCount, starColor: self.starColor, starHighlightColor: self.starHighlightColor, spaceBetweenStar: self.spaceBetweenStar)
        addSubview(starRating)
    }
    
    #else
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let starRating = JWStarRating(frame: self.bounds, starCount: self.starCount, starColor: self.starColor, starHighlightColor: self.starHighlightColor, spaceBetweenStar: self.spaceBetweenStar)
        starRating.addTarget(self, action: #selector(JWStarRatingView.valueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        addSubview(starRating)
        
    }
    #endif
    
    func valueChanged(starRating:JWStarRating){
        // Do something with the value...
        print("Value changed \(starRating.ratedStarIndex)")
    }
}
