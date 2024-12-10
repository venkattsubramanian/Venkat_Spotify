//
//  Constraints.swift
//  Carspa
//
//  Created by Ait iMac 02 on 15/04/24.
//

import Foundation

import UIKit

// MARK: - NSLayoutDimension
extension NSLayoutDimension {
    struct Dimension {
        let constraint: NSLayoutDimension
        let constant: CGFloat?
        let multiplier: CGFloat
    }
    
    @discardableResult
    static func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalToConstant: rhs)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualToConstant: rhs)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
}

// MARK: - NSLayoutXAxisAnchor

extension NSLayoutXAxisAnchor {
    struct Constraint {
        let constraint: NSLayoutXAxisAnchor
        let constant: CGFloat
    }
    
    @discardableResult
    static func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func == (lhs: NSLayoutXAxisAnchor, rhs: Constraint) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs.constraint, constant: rhs.constant)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func >= (lhs: NSLayoutXAxisAnchor, rhs: Constraint) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.constraint, constant: rhs.constant)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func <= (lhs: NSLayoutXAxisAnchor, rhs: Constraint) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.constraint, constant: rhs.constant)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func + (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> Constraint {
        return Constraint(constraint: lhs, constant: rhs)
    }
    
    @discardableResult
    static func + (lhs: NSLayoutXAxisAnchor, rhs: Double) -> Constraint {
        return lhs + CGFloat(rhs)
    }
    
    @discardableResult
    static func - (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> Constraint {
        return Constraint(constraint: lhs, constant: -rhs)
    }
}

// MARK: - NSLayoutYAxisAnchor

extension NSLayoutYAxisAnchor {
    struct Constraint {
        let constraint: NSLayoutYAxisAnchor
        let value: CGFloat
    }
    
    @discardableResult
    static func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func == (lhs: NSLayoutYAxisAnchor, rhs: Constraint) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs.constraint, constant: rhs.value)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func >= (lhs: NSLayoutYAxisAnchor, rhs: Constraint) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.constraint, constant: rhs.value)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func <= (lhs: NSLayoutYAxisAnchor, rhs: Constraint) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.constraint, constant: rhs.value)
        constraint.isActive = true
        (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        return constraint
    }
    
    @discardableResult
    static func + (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> Constraint {
        return Constraint(constraint: lhs, value: rhs)
    }
    
    @discardableResult
    static func - (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> Constraint {
        return Constraint(constraint: lhs, value: -rhs)
    }
}

// MARK: - LayoutCenterAnchor

struct LayoutCenterAnchor {
    let centerX: NSLayoutXAxisAnchor
    let centerY: NSLayoutYAxisAnchor
    
    @discardableResult
    static func == (lhs: LayoutCenterAnchor, rhs: LayoutCenterAnchor) -> [NSLayoutConstraint] {
        let centerX = lhs.centerX == rhs.centerX
        let centerY = lhs.centerY == rhs.centerY
        return [centerX, centerY]
    }
}

// MARK: - LayoutEdgesAnchor

struct LayoutEdgesAnchor {
    let top: NSLayoutYAxisAnchor
    let trailing: NSLayoutXAxisAnchor
    let bottom: NSLayoutYAxisAnchor
    let leading: NSLayoutXAxisAnchor
    
    struct Constraint {
        let edges: LayoutEdgesAnchor
        let insets: UIEdgeInsets
    }
    
    @discardableResult
    static func == (lhs: LayoutEdgesAnchor, rhs: LayoutEdgesAnchor) -> [NSLayoutConstraint] {
        let top = lhs.top == rhs.top
        let trailing = lhs.trailing == rhs.trailing
        let bottom = lhs.bottom == rhs.bottom
        let leading = lhs.leading == rhs.leading
        return [top, trailing, bottom, leading]
    }
}
// MARK: - UIView

extension UIView {
    
    var leading: NSLayoutXAxisAnchor {
        return leadingAnchor
    }
    
    var trailing: NSLayoutXAxisAnchor {
        return trailingAnchor
    }
    
    var top: NSLayoutYAxisAnchor {
        return topAnchor
    }
    
    var bottom: NSLayoutYAxisAnchor {
        return bottomAnchor
    }
    
    var width: NSLayoutDimension {
        return widthAnchor
    }
    
    var height: NSLayoutDimension {
        return heightAnchor
    }
    
    var centerX: NSLayoutXAxisAnchor {
        return centerXAnchor
    }
    
    var centerY: NSLayoutYAxisAnchor {
        return centerYAnchor
    }
    
    var mid: LayoutCenterAnchor {
        return LayoutCenterAnchor(centerX: centerX, centerY: centerY)
    }
    
    var edges: LayoutEdgesAnchor {
        return LayoutEdgesAnchor(top: top, trailing: trailing, bottom: bottom, leading: leading)
    }
}
