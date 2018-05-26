//
//  ViewController.swift
//  AltAutoLayout
//
//  Created by ちゅーたつ on 2018/03/30.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit




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
    
    func activateLayoutAnchorYAxis(_ constrain: VerticalConstraints, target: LayoutTarget.YAxis) {
        
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
    

    func setWidthConstraint(_ width: DimensionalConstraints) {
        activateLayoutAnchorDimension(width, target: .width)
    }
    
    func setHeightConstraint(_ height: DimensionalConstraints) {
         activateLayoutAnchorDimension(height, target: .height)
    }
    
    func setRightConstraint(_ right: HorizontalConstraints) {
        activateLayoutAnchorXAxis(right, target: .right)
    }
    
    func setLeftConstraint(_ left: HorizontalConstraints) {
        activateLayoutAnchorXAxis(left, target: .left)
    }
    
    func setCenterXConstraint(_ centerX: HorizontalConstraints) {
        activateLayoutAnchorXAxis(centerX, target: .centerX)
    }
    
    func setTopConstraint(_ top: VerticalConstraints) {
        activateLayoutAnchorYAxis(top, target: .top)
    }

    func setBottomConstraint(_ bottom: VerticalConstraints) {
         activateLayoutAnchorYAxis(bottom, target: .bottom)
    }
    
    func setCenterYConstraint(_ centerY: VerticalConstraints) {
        activateLayoutAnchorYAxis(centerY, target: .centerY)
    }
}

extension NSLayoutConstraint {
    
    func activate() {
        isActive = true
    }
}


extension LayoutMaker {
    static func constraint(_ target: UIView, _ view1: UIView, _ view2: UIView , closure: ((LayoutMaker, AnchorShortcut, AnchorShortcut)->Swift.Void)) {
        closure(LayoutMaker(target), AnchorShortcut(view1), AnchorShortcut(view2))
    }
}

class ChuraLayout {
    
    var target: UIView
    
    init (_ target: UIView) {
        self.target = target
    }
    
    func constrainWith(_ view1: UIView, _ view2: UIView, closure: ((LayoutMaker, AnchorShortcut, AnchorShortcut)->Swift.Void)) {
        closure(LayoutMaker(target), AnchorShortcut(view1), AnchorShortcut(view2))
    }
}

extension UIView {
    
    var chura: ChuraLayout {
        return ChuraLayout(self)
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
//
//
//        red.layout.constraintsWith(view, view) { superView, imageView in
//
//        }
        
        
        red.chura.constrainWith(view, view) { red, superView, _ in
            red.setTopConstraint(superView.top + 50)
            red.setWidthConstraint(CGFloat(300))
            red.setHeightConstraint(CGFloat(300))
            red.setLeftConstraint(superView.left)
        }
   
        blue.chura.constrainWith(red, view) { blue, red, superView in
            blue.setTopConstraint(red.bottom)
            blue.setLeftConstraint(red.right)
            blue.setRightConstraint(superView.right)
            blue.setBottomConstraint(superView.bottom)
        }
        
        green.chura.constrainWith(view, view) { green, superView, _ in
            green.setCenterXConstraint(superView.centerX)
            green.setCenterYConstraint(superView.centerY)
            green.setHeightConstraint(CGFloat(100))
            green.setWidthConstraint(superView.width + (-30))
        }
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

