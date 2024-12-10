//
//  CustomButton.swift
//  Carspa
//
//  Created by Ait iMac 02 on 15/04/24.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    enum ButtonStyle {
        case primary, secondary, back
        
        var properties: (backgroundColor: UIColor, titleColor: UIColor?, font: UIFont?, cornerRadius: CGFloat?, text: String?, shadowColor: UIColor?, shadowOffset: CGSize?, shadowOpacity: Float?, shadowRadius: CGFloat?, buttonImageName: String?, systemButtonImageName: String?, tintColor: UIColor?) {
            switch self {
            case .primary: return (.clear, .darkomodecolor1, .primaryFont(size: 18), .aspectHeight(15), nil, nil, nil, nil, nil, nil, nil, nil)
            case .secondary: return (.clear, .Menu, .primaryMediumFont(size: 16), .aspectHeight(15), nil, nil, nil, nil, nil, nil, nil, nil)
            case .back: return (.clear, .Menu, .primaryMediumFont(size: 16), .aspectHeight(15), nil, nil, nil, nil, nil, nil, "arrow.left", .darkomodecolor1)
           
            }
        }
    }
    
    private var action: (() -> Void)?
    
    init(style: ButtonStyle, action: (() -> Void)? = nil) {
        self.action = action
        super.init(frame: .zero)
        setupButton(style: style)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupButton(style: ButtonStyle) {
        let props = style.properties
        setTitle(props.text, for: .normal)
        setTitleColor(props.titleColor, for: .normal)
        titleLabel?.font = props.font
        backgroundColor = props.backgroundColor
        
        if let cornerRadius = props.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        
        if let shadowColor = props.shadowColor, let shadowOffset = props.shadowOffset, let shadowOpacity = props.shadowOpacity, let shadowRadius = props.shadowRadius {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
        
        updateImage(buttonImageName: props.buttonImageName, systemButtonImageName: props.systemButtonImageName, tintColor: props.tintColor)
    }
    
    private func updateImage(buttonImageName: String?, systemButtonImageName: String?, tintColor: UIColor?) {
        if let imageName = buttonImageName, let image = UIImage(named: imageName) {
            setImage(image, for: .normal)
            self.tintColor = tintColor
        } else if let systemImageName = systemButtonImageName, let image = UIImage(systemName: systemImageName) {
            setImage(image, for: .normal)
            self.tintColor = tintColor
        } else {
            setImage(nil, for: .normal)
        }
    }
    
    @objc private func buttonTapped() {
        action?()
    }
}


extension UIButton {
    
    var buttonTitle: String? {
        set {
            setTitle(newValue, for: .normal)
        }
        get {
            return titleLabel?.text
        }
    }
    
    var buttonImage: UIImage? {
        set {
            setImage(newValue, for: .normal)
        }
        get {
            return imageView?.image
        }
    }
    
    var buttonTitleFont: UIFont? {
        set {
            titleLabel?.font = newValue
        }
        get {
            return titleLabel?.font
        }
    }
    
    var buttonTitleColor: UIColor {
        set {
            setTitleColor(newValue, for: .normal)
        }
        get {
            return titleColor(for: .normal) ?? .appBlackColor
        }
    }
    
    var buttonTitleAlignment: NSTextAlignment {
        set {
            titleLabel?.textAlignment = newValue
        }
        get {
            return titleLabel?.textAlignment ?? .left
        }
    }
    
}

extension UIButton {
    public func setImage(_ image: UIImage?) {
        for state : UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setImage(image, for: state)
        }
    }
}

@IBDesignable class GradientButton: UIButton {
    
    @IBInspectable var startColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }
    @IBInspectable var endColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.3){
        didSet{
            gradientLayer.startPoint = startPoint
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0){
        didSet{
            gradientLayer.endPoint = endPoint
        }
    }
    
    open var gcornerRadius: CGFloat?
    
    let gradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        clipsToBounds = true
        gradientLayer.frame = rect
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
