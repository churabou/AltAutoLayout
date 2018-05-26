//
//  AnchorShortcut.swift
//  AltAutoLayout
//
//  Created by ちゅーたつ on 2018/05/26.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

class AnchorShortcut {
    
    var base: UIView
    init (_ base: UIView) {
        self.base = base
    }
    
    var right: NSLayoutXAxisAnchor {
        return base.rightAnchor
    }
    
    var left: NSLayoutXAxisAnchor {
        return base.leftAnchor
    }
    
    var top: NSLayoutYAxisAnchor {
        return base.topAnchor
    }
    
    var bottom: NSLayoutYAxisAnchor {
        return base.bottomAnchor
    }
    
    var width: NSLayoutDimension {
        return base.widthAnchor
    }
    
    var height: NSLayoutDimension {
        return base.heightAnchor
    }
    
    var centerX: NSLayoutXAxisAnchor {
        return base.centerXAnchor
    }
    
    var centerY: NSLayoutYAxisAnchor {
        return base.centerYAnchor
    }
}
