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

    func activateLayoutAnchorXAxis(_ constrain: HorizontalConstraints, target: LayoutTarget.XAxis) {
        
        let anchor = base.layoutAnchor(target)
        
        if let constrain = constrain as? Wrapper<NSLayoutXAxisAnchor> {
            anchor.constraint(equalTo: constrain.target, constant: constrain.amount).activate()
        } else
        
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
}


extension LayoutMaker {
    
    
    func LayoutX(left: HorizontalConstraints, right: HorizontalConstraints) {
        activateLayoutAnchorXAxis(left, target: .left)
        activateLayoutAnchorXAxis(right, target: .right)
    }
    
    func LayoutX(right: HorizontalConstraints, width: DimensionalConstraints) {
        activateLayoutAnchorXAxis(right, target: .right)
        activateLayoutAnchorDimension(width, target: .width)
    }
    
    func LayoutX(left: HorizontalConstraints, width: DimensionalConstraints) {
        activateLayoutAnchorXAxis(left, target: .left)
        activateLayoutAnchorDimension(width, target: .width)
    }
    
    func LayoutX(centerX: HorizontalConstraints, width: DimensionalConstraints) {
        activateLayoutAnchorXAxis(centerX, target: .centerX)
        activateLayoutAnchorDimension(width, target: .width)
    }
}

extension LayoutMaker {
    
    
    func LayoutY(top: VerticalConstraints, bottom: VerticalConstraints) {
        activateLayoutAnchorYAxis(top, target: .top)
        activateLayoutAnchorYAxis(bottom, target: .bottom)
    }
    
    func LayoutY(top: VerticalConstraints, height: DimensionalConstraints) {
        activateLayoutAnchorYAxis(top, target: .top)
        activateLayoutAnchorDimension(height, target: .height)
    }
    
    func LayoutY(bottom: VerticalConstraints, height: DimensionalConstraints) {
        activateLayoutAnchorYAxis(bottom, target: .bottom)
        activateLayoutAnchorDimension(height, target: .height)
    }
    
    func LayoutY(centerY: VerticalConstraints, height: DimensionalConstraints) {
        activateLayoutAnchorYAxis(centerY, target: .centerY)
         activateLayoutAnchorDimension(height, target: .height)
    }
}



extension NSLayoutConstraint {
    
    func activate() {
        isActive = true
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
        
        
        red.chura.constrainWith(view, view) { red, superView, _ in
            red.LayoutX(left: superView.left, width: CGFloat(300))
            red.LayoutY(top: superView.top+50, height: CGFloat(300))
        }
   
        blue.chura.constrainWith(red, view) { blue, red, superView in
            blue.LayoutX(left: red.left, right: superView.right)
            blue.LayoutY(top: red.bottom, bottom: superView.bottom)
        }
        
        green.chura.constrainWith(view, view) { green, superView, _ in
            green.LayoutX(centerX: superView.centerX,
                          width: superView.width + (-30))
            green.LayoutY(centerY: superView.centerY,
                          height: CGFloat(100))
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

