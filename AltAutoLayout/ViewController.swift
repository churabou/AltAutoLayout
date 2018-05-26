//
//  ViewController.swift
//  AltAutoLayout
//
//  Created by ちゅーたつ on 2018/03/30.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit



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
    
    
    var layout: LayoutMaker {
        
        self.snp.makeConstraints { (make) in
//            make.left.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
        }
        return LayoutMaker(self)
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




extension CGFloat: HorizontalConstraints, VerticalConstraints, DimensionalConstraints {
}

extension UIView: HorizontalConstraints, VerticalConstraints {
    
}

class Wrapper<T> {
    
    var target: T
    var amount: CGFloat
    
    init(target: T, amount: CGFloat) {
        self.target = target
        self.amount = amount
    }
}


extension Wrapper: HorizontalConstraints where T == NSLayoutXAxisAnchor {
}

extension Wrapper: VerticalConstraints where T == NSLayoutYAxisAnchor {
}

extension Wrapper: DimensionalConstraints where T == NSLayoutDimension {
}


class LayoutMaker {
    
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
    
    func activateLayoutAnchorXAxis(_ constrain: HorizontalConstraints, target: LayoutTarget.XAxis) {
        
        let anchor = base.layoutAnchor(target)
        
        if let constrain = constrain as? Wrapper<NSLayoutXAxisAnchor> {
            anchor.constraint(equalTo: constrain.target, constant: constrain.amount).activate()
        }
        
        if let constrain = constrain as? NSLayoutXAxisAnchor {
            anchor.constraint(equalTo: constrain).activate()
        }
        
        if let view = constrain as? UIView {
            anchor.constraint(equalTo: view.layoutAnchor(target)).activate()
        }
        
        if let constrain = constrain as? CGFloat {
            anchor.constraint(equalTo: base.superview!.layoutAnchor(target), constant: constrain).activate()
        }
    }
    
    func activateLayoutAnchorYAxis(_ constrain: HorizontalConstraints, target: LayoutTarget.YAxis) {
        
        let anchor = base.layoutAnchor(target)
        
        if let constrain = constrain as? Wrapper<NSLayoutYAxisAnchor> {
            anchor.constraint(equalTo: constrain.target, constant: constrain.amount).activate()
        }
        
        if let constrain = constrain as? NSLayoutYAxisAnchor {
            anchor.constraint(equalTo: constrain).activate()
        }
        
        if let view = constrain as? UIView {
            anchor.constraint(equalTo: view.layoutAnchor(target)).activate()
        }
        
        if let constrain = constrain as? CGFloat {
            anchor.constraint(equalTo: base.superview!.layoutAnchor(target), constant: constrain).activate()
        }
    }
    
    
    func activateLayoutAnchorDimension(_ constrain: DimensionalConstraints, target: LayoutTarget.Dimension) {
        
        let anchor = base.layoutAnchor(target)
        if let constrain = constrain as? Wrapper<NSLayoutDimension> {
            anchor.constraint(equalTo: constrain.target, multiplier: 1, constant: constrain.amount).activate()
        }
        
        if let constrain = constrain as? NSLayoutDimension {
            anchor.constraint(equalTo: constrain).activate()
        }
        
        if let view = constrain as? UIView {
            anchor.constraint(equalTo: view.layoutAnchor(target), multiplier: 1).activate()
        }
        
        if let constant = constrain as? CGFloat {
            anchor.constraint(equalToConstant: constant).activate()
        }
    }
    
    //right + 10 or right or Int or View
    func constrainX(right: HorizontalConstraints) {
        
    }
    
    func setWidthConstraint(_ width: DimensionalConstraints) {
     
        if let width = width as? Wrapper<NSLayoutDimension> {
            base.widthAnchor.constraint(equalTo: width.target, multiplier: 1, constant: width.amount).activate()
        }
        
        if let width = width as? NSLayoutDimension {
            base.widthAnchor.constraint(equalTo: width).activate()
        }
        
        if let view = width as? UIView {
            base.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).activate()
        }
        
        if let width = width as? CGFloat {
            base.widthAnchor.constraint(equalToConstant: width).activate()
        }
    }
    
    func setHeightConstraint(_ height: DimensionalConstraints) {
        
        if let height = height as? Wrapper<NSLayoutDimension> {
            base.heightAnchor.constraint(equalTo: height.target, multiplier: 1, constant: height.amount).activate()
        }
        
        if let height = height as? NSLayoutDimension {
            base.heightAnchor.constraint(equalTo: height).activate()
        }
        
        if let view = height as? UIView {
            base.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).activate()
        }
        
        if let height = height as? CGFloat {
            base.heightAnchor.constraint(equalToConstant: height).activate()
        }
    }
    
    func setRightConstraint(_ right: HorizontalConstraints) {

        if let right = right as? Wrapper<NSLayoutXAxisAnchor> {
            base.rightAnchor.constraint(equalTo: right.target, constant: right.amount).activate()
        }
        
        if let right = right as? NSLayoutXAxisAnchor {
            base.rightAnchor.constraint(equalTo: right).activate()
        }
        
        if let right = right as? UIView {
            base.rightAnchor.constraint(equalTo: right.rightAnchor).activate()
        }
        
        if let right = right as? CGFloat {
            base.rightAnchor.constraint(equalTo: base.superview!.rightAnchor, constant: right).activate()
        }
    }
    
    func setLeftConstraint(_ left: HorizontalConstraints) {
        
        if let left = left as? Wrapper<NSLayoutXAxisAnchor> {
            base.leftAnchor.constraint(equalTo: left.target, constant: left.amount).activate()
        }
        
        if let left = left as? NSLayoutXAxisAnchor {
            base.leftAnchor.constraint(equalTo: left).activate()
        }
        
        if let left = left as? UIView {
            base.leftAnchor.constraint(equalTo: left.leftAnchor).activate()
        }
        
        if let left = left as? CGFloat {
            base.leftAnchor.constraint(equalTo: base.superview!.leftAnchor, constant: left).activate()
        }
    }
    
    
    func setTopConstraint(_ top: VerticalConstraints) {

        //equalTo(view.snp.bottom).offSet(10)
        if let top = top as? Wrapper<NSLayoutYAxisAnchor> {
            base.topAnchor.constraint(equalTo: top.target, constant: top.amount).activate()
        }
        //ex, equalTo(view.snp.bottom)
        if let top = top as? NSLayoutYAxisAnchor {
            base.topAnchor.constraint(equalTo: top).activate()
        }
        
        if let top = top as? UIView {
            base.topAnchor.constraint(equalTo: top.topAnchor).activate()
        }
        
        if let top = top as? CGFloat {
            base.topAnchor.constraint(equalTo: base.superview!.topAnchor, constant: top).activate()
        }
    }
    
    
    func setBottomConstraint(_ bottom: VerticalConstraints) {
        
        //equalTo(view.snp.bottom).offSet(10)
        if let bottom = bottom as? Wrapper<NSLayoutYAxisAnchor> {
            base.bottomAnchor.constraint(equalTo: bottom.target, constant: bottom.amount).activate()
        }
        //ex, equalTo(view.snp.bottom)
        if let bottom = bottom as? NSLayoutYAxisAnchor {
            base.bottomAnchor.constraint(equalTo: bottom).activate()
        }
        
        if let bottom = bottom as? UIView {
            base.bottomAnchor.constraint(equalTo: bottom.bottomAnchor).activate()
        }
        
        if let bottom = bottom as? CGFloat {
            base.bottomAnchor.constraint(equalTo: base.superview!.bottomAnchor, constant: bottom).activate()
        }
    }
}

extension NSLayoutConstraint {
    
    func activate() {
        isActive = true
    }
}
class ViewController: UIViewController {
    
    let red = UIView()
    let blue = UIView()
    let green = UIView()
    
    
    override func viewDidLoad() {
        
        
        view.backgroundColor = .white
        view.addSubview(red)
        view.addSubview(blue)
        view.addSubview(green)
        
        red.backgroundColor = .red
        blue.backgroundColor = .blue
        green.backgroundColor = .green
        
        red.translatesAutoresizingMaskIntoConstraints = false
        blue.translatesAutoresizingMaskIntoConstraints = false
        green.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        red.layout.setTopConstraint(view.layout.top + 50)
        red.layout.setWidthConstraint(CGFloat(300))
        red.layout.setHeightConstraint(CGFloat(300))
        red.layout.setLeftConstraint(view)
        
        
        
        blue.layout.setTopConstraint(red.layout.bottom)
        blue.layout.setLeftConstraint(red.layout.right)
        blue.layout.setRightConstraint(view)
        blue.layout.setBottomConstraint(view)
        
        
        green.layout.setTopConstraint(red.layout.bottom)
        green.layout.setLeftConstraint(CGFloat(0))
        green.layout.setHeightConstraint(CGFloat(100))
        green.layout.setWidthConstraint(CGFloat(50))
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 0.5
        red.layer.add(rotateAnimation, forKey: nil)
        
//        UIView.animate(withDuration: 0.5) {
//            self.red.transform = self.red.transform.rotated(by: 270 * CGFloat.pi / 180)
//        }
    }
}

