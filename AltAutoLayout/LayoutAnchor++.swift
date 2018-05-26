//
//  LayoutAnchor++.swift
//  AltAutoLayout
//
//  Created by ちゅーたつ on 2018/05/26.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

enum LayoutTarget {
    
    enum XAxis {
        case left, right, centerX
    }
    
    enum YAxis {
        case top, bottom, centerY
    }
    
    enum Dimension {
        case width, height
    }
}

extension UIView {

    func layoutAnchor(_ target: LayoutTarget.XAxis) -> NSLayoutXAxisAnchor {
        switch target {
        case .left: return leftAnchor
        case .right: return rightAnchor
        case .centerX: return centerXAnchor
        }
    }
    
    func layoutAnchor(_ target: LayoutTarget.YAxis) -> NSLayoutYAxisAnchor {
        switch target {
        case .top: return topAnchor
        case .bottom: return bottomAnchor
        case .centerY: return centerYAnchor
        }
    }
    
    func layoutAnchor(_ target: LayoutTarget.Dimension) -> NSLayoutDimension {
        switch target {
        case .width: return widthAnchor
        case .height: return heightAnchor
        }
    }
}


// left, right, centerX
protocol HorizontalConstraints {
}

// top, bottom, centerY
protocol VerticalConstraints {
}

// width, height
protocol DimensionalConstraints {
}


extension NSLayoutXAxisAnchor: HorizontalConstraints {
}

extension NSLayoutYAxisAnchor: VerticalConstraints {
}

extension NSLayoutDimension: DimensionalConstraints {
}


typealias ConstraintsTarget = HorizontalConstraints & VerticalConstraints & DimensionalConstraints

extension CGFloat: ConstraintsTarget {
}

extension UIView: ConstraintsTarget {
}



class Wrapper<T> {
    
    var target: T
    var amount: CGFloat
    
    init(target: T, amount: CGFloat) {
        self.target = target
        self.amount = amount
    }
}

//この2つも多分共通化できるはず。
extension NSLayoutXAxisAnchor {
    
    static func +(lhd: NSLayoutXAxisAnchor, rhd: CGFloat) -> Wrapper<NSLayoutXAxisAnchor> {
        return Wrapper(target: lhd, amount: rhd)
    }
}

extension NSLayoutYAxisAnchor {
    static func +(lhd: NSLayoutYAxisAnchor, rhd: CGFloat) -> Wrapper<NSLayoutYAxisAnchor> {
        return Wrapper(target: lhd, amount: rhd)
    }
}

extension NSLayoutDimension {
    static func +(lhd: NSLayoutDimension, rhd: CGFloat) -> Wrapper<NSLayoutDimension> {
        return Wrapper(target: lhd, amount: rhd)
    }
}


extension Wrapper: HorizontalConstraints where T == NSLayoutXAxisAnchor {
}

extension Wrapper: VerticalConstraints where T == NSLayoutYAxisAnchor {
}

extension Wrapper: DimensionalConstraints where T == NSLayoutDimension {
}
