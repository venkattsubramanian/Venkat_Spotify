//
//  UIView.swift
//  Venkat_Spotify
//
//  Created by Achu Anil's MacBook Pro on 10/12/24.
//

import Foundation
import UIKit

extension UIView{
    
    var borderColor: UIColor? {
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
    
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue?.cgColor
        }
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    var masksToBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }
}
