//
//  LoadingView.swift
//  IWatchLoading
//
//  Created by Mingbao on 15/1/25.
//  Copyright (c) 2015年 Mingbao. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    var animationViews = NSMutableArray()
    
    override init(frame: CGRect)
    {
        var newframe = CGRectMake(frame.origin.x, frame.origin.y, 160, 160)
        super.init(frame: newframe)
        
    }
    
    func setup()
    {
        var centerX = self.frame.size.width/2
        var centerY = self.frame.size.height/2
        
        var deltaAngle:Double = 2 * M_PI / 8
        
        var radius = self.frame.size.width / 2 - 4
        
        for(var index = 0; index < 8; index++)
        {
            var cosValue = cos(deltaAngle * Double(index))
            
            var x = radius * CGFloat(cosValue) + centerX
            
            var sinValue = sin(deltaAngle * Double(index))
            
            var y = radius * CGFloat(sinValue) + centerY
            
            var view = UIView(frame: CGRectMake(x-4, y-4, 8, 8))
            
            view.backgroundColor = UIColor.redColor()
            
            view.layer.cornerRadius = 4;
            view.clipsToBounds = true
            
            self.addSubview(view)
            
            setupAnimation(view, index: index, fromPosition: view.center, toPosition: CGPointMake(centerX, centerY), fromScale: 1.0, toScale: 0.1)
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }

    func setupAnimation(view: UIView, index: NSInteger, fromPosition: CGPoint, toPosition: CGPoint, fromScale: CGFloat, toScale: CGFloat)
    {
        var animation = CABasicAnimation(keyPath: "position")
        
        animation.fromValue = NSValue(CGPoint: fromPosition)
        animation.toValue = NSValue(CGPoint: toPosition)
        
        animation.duration = 0.75
        animation.autoreverses = true

        var scaleAnimation = CABasicAnimation(keyPath: "scale")
        
        scaleAnimation.fromValue = fromScale//NSNumber(CGFloat: fromScale)
        scaleAnimation.toValue = toScale//(CGFloat: toScale)
        scaleAnimation.duration = 0.75
        scaleAnimation.autoreverses = true
        
        var animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation, scaleAnimation]
        animationGroup.autoreverses = true
        animationGroup.duration = 0.75
        animationGroup.beginTime = CACurrentMediaTime() + Double(index) * 0.1
        animationGroup.repeatCount = Float(Int.max)
        view.layer.addAnimation(animationGroup, forKey: "position and scale")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
