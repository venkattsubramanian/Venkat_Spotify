//
//  Extension+UIView.swift
//  QliQ1
//
//  Created by Anilkumar on 01/07/21.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var viewCornerRadius: CGFloat {
        set {
            layer.cornerRadius = isCircle ? min(bounds.size.height, bounds.size.width) / 2 : newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var isCircle: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == viewCornerRadius
        }
        set {
            viewCornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : viewCornerRadius
        }
    }
    @IBInspectable var shadowColor: UIColor {
        set {
            layer.shadowColor = newValue.cgColor
        }
        get {
            guard let color = layer.shadowColor else {
                return .clear
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    @IBInspectable var maskBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }
    
    func layoutAnchor (_ layout: layoutModel) {
        
        let insets = self.safeAreaInsets
        let topInset = insets.top
        let bottomInset = insets.bottom
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = layout.top , let padding = layout.paddingTop {
            self.topAnchor.constraint(equalTo: top, constant: padding + topInset).isActive = true
        }
        if let left = layout.left , let padding = layout.paddingLeft{
            self.leftAnchor.constraint(equalTo: left, constant: padding).isActive = true
        }
        if let right = layout.right , let padding = layout.paddingRight{
            rightAnchor.constraint(equalTo: right, constant: -padding).isActive = true
        }
        if let bottom = layout.bottom , let padding = layout.paddingBottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding-bottomInset).isActive = true
        }
        if let centerX = layout.centerX{
            centerXAnchor.constraint(equalTo: centerX, constant: 0.0).isActive = true
        }
        if let centerY = layout.centerY{
            centerYAnchor.constraint(equalTo: centerY, constant: 0.0).isActive = true
        }
        if let height = layout.height, height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = layout.width , width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
    
    func addSubviews(with views: [UIView]) {
        views.forEach { (view) in
            addSubview(view)
        }
    }

    func bringSubviewsToFront(with views: [UIView]) {
        views.forEach { (view) in
            bringSubviewToFront(view)
        }
    }
    
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    struct layoutModel {
        var top: NSLayoutYAxisAnchor? = nil
        var left: NSLayoutXAxisAnchor? = nil
        var bottom: NSLayoutYAxisAnchor? = nil
        var right: NSLayoutXAxisAnchor? = nil
        var centerX : NSLayoutXAxisAnchor? = nil
        var centerY : NSLayoutYAxisAnchor? = nil
        var paddingTop: CGFloat? = nil
        var paddingLeft: CGFloat? = nil
        var paddingBottom: CGFloat? = nil
        var paddingRight: CGFloat? = nil
        var width: CGFloat? = nil
        var height: CGFloat? = nil
    }
}



extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

