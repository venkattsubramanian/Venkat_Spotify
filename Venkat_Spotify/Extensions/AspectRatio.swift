//
//  AspectRatio.swift
//  Carspa
//
//  Created by Ait iMac 02 on 15/04/24.
//

import Foundation
import UIKit

extension CGFloat {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth  = UIScreen.main.bounds.width

    static func aspectHeight(_ val: CGFloat) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return self.screenHeight * (val / 852)
        case .pad:
            return self.screenHeight * (val / 1024)
        default:
            return val
        }
    }

    static func aspectWidth(_ val: CGFloat) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return self.screenWidth * (val / 393)
        case .pad:
            return self.screenWidth * (val / 768)
        default:
            return val
        }
    }
}
