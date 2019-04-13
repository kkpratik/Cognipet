//
//  ActivityIndicatorHud.swift
//  Cognipet
//
//  Created by ShivamSevarik on 03/01/19.
//  Copyright © 2019 SS Incorporation. All rights reserved.
//

import UIKit

class ActivityIndicatorHud: UIView
{
    let indicator:UIActivityIndicatorView
    var parentView:UIView?
    var isFirstTime = true
    
    
    override init(frame: CGRect)
    {
        self.indicator = UIActivityIndicatorView()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.indicator = UIActivityIndicatorView()
        super.init(coder: aDecoder)
    }
 
    override func layoutSubviews()
    {
        if self.isFirstTime
        {
            DispatchQueue.main.async {
                
                self.isFirstTime = false
                
                self.translatesAutoresizingMaskIntoConstraints = false
                
                self.addSubview(self.indicator)
                let centerX = NSLayoutConstraint.init(item: self.indicator,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: self,
                                                      attribute: .centerX,
                                                      multiplier: 1,
                                                      constant: 0)
                
                centerX.isActive = true
                
                let centerY = NSLayoutConstraint.init(item: self.indicator,
                                                      attribute: .centerY,
                                                      relatedBy: .equal,
                                                      toItem: self,
                                                      attribute: .centerY,
                                                      multiplier: 1,
                                                      constant: 0)
                
                centerY.isActive = true
                
                self.parentView?.addConstraint(centerX)
                self.parentView?.addConstraint(centerY)
            }
        }
    }
    
    public func start()
    {
        DispatchQueue.main.async {
            
            if let parentView = self.parentView
            {
                if let superView = self.superview,
                    superView != parentView
                {
                    self.removeFromSuperview()
                    self.parentView?.addSubview(self)
                }
                else
                {
                    self.parentView?.addSubview(self)
                }
                
                if !self.indicator.isAnimating
                {
                    self.indicator.startAnimating()
                }
            }
        }
    }
    
    public func stop()
    {
        DispatchQueue.main.async {
            
            if self.indicator.isAnimating
            {
                self.indicator.stopAnimating()
            }
            
            if self.superview != nil
            {
                self.removeFromSuperview()
            }
        }
    }
}
