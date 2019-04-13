//
//  ColorStack.swift
//  Njoy.ai
//
//  Created by Apple on 17/10/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

@objcMembers
@objc class ColorStack: NSObject {
    
    var mainStack : NSMutableArray?
    var undoStack : NSMutableArray?
    var redoStack : NSMutableArray?
    var selectedImage : UIImage?
    @objc var isNewImage : Bool = true
    @objc var undoLevel : Int = 5
    @objc var colorCounter : Int = 0
    static let shared : ColorStack = ColorStack()
}
