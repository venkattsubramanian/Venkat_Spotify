//
//  UIColor.swift
//  Carspa
//
//  Created by Ait iMac 02 on 15/04/24.
//

import Foundation
import UIKit

extension UIColor {
    
    /*
     App White Color
     RGB - UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
     HEX - FFFFFF
     */
    static let appWhiteColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    /*
     App Black Color
     RGB - UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
     HEX - 000000
     */
    static let appBlackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    /*
     Fp Button Color
     RGB - UIColor(red: 0.0039, green: 0.6118, blue: 0.4863, alpha: 1.0)
     HEX - 019c7c
     */
    static let FpBtnClr = #colorLiteral(red: 0.00392156863, green: 0.6117647059, blue: 0.4862745098, alpha: 1.0)
    
    /*
     Login Color
     RGB - UIColor(red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0)
     HEX - eeeeee
     */
    static let logincolor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1.0)
    
    /*
     Menu Color
     RGB - UIColor(red: 0.0, green: 0.4235, blue: 0.6745, alpha: 1.0)
     HEX - 006cac
     */
    static let Menu = #colorLiteral(red: 0.0, green: 0.4235294118, blue: 0.6745098039, alpha: 1.0)
    
    /*
     Signup Color
     RGB - UIColor(red: 0.9765, green: 0.8, blue: 0.2588, alpha: 1.0)
     HEX - f9cc42
     */
    static let Signup = #colorLiteral(red: 0.9764705882, green: 0.8, blue: 0.2588235294, alpha: 1.0)
    
    /*
     Signup Button Title Color
     RGB - UIColor(red: 0.0, green: 0.1647, blue: 0.2196, alpha: 1.0)
     HEX - 002a38
     */
    static let SignupButtonTitleColor = #colorLiteral(red: 0.0, green: 0.1647058824, blue: 0.2196078431, alpha: 1.0)
    
    /*
     Services Layout Background Color
     RGB - UIColor(red: 0.8510, green: 0.9294, blue: 0.9686, alpha: 1.0)
     HEX - d9edf7
     */
    static let ServicesLayoutbackgroundcolor = #colorLiteral(red: 0.8509803922, green: 0.9294117647, blue: 0.968627451, alpha: 1.0)
    
    /*
     Layout Color
     RGB - UIColor(red: 0.0, green: 0.5294, blue: 0.7804, alpha: 1.0)
     HEX - 0087c7
     */
    static let layoutColor = #colorLiteral(red: 0.0, green: 0.5294117647, blue: 0.7803921569, alpha: 1.0)
    
    /*
     Custom Text Color
     RGB - UIColor(red: 1.0, green: 0.8078, blue: 0.1490, alpha: 1.0)
     HEX - ffce26
     */
    static let customTextColor = #colorLiteral(red: 1.0, green: 0.8078431373, blue: 0.1490196078, alpha: 1.0)
    
    static let mixedColor = #colorLiteral(red: 0.0/255.0, green: 50.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    
    static let searchbartextcolor = UIColor(named: "searchBarTextColor") ?? .darkGray
    
    static let darkomodecolor1 = UIColor { $0.userInterfaceStyle == .dark ? .appWhiteColor : .appBlackColor }
    
    static let darkmodegrayandwhite = UIColor { $0.userInterfaceStyle == .dark ? .searchbartextcolor : .appWhiteColor }
    
    static let refreshdark = UIColor { $0.userInterfaceStyle == .dark ? .appWhiteColor : .Menu }
    
    static let darkmodewhiteandgray = UIColor { $0.userInterfaceStyle == .dark ? .appWhiteColor : .gray }

    static let darkModeToast = UIColor { $0.userInterfaceStyle == .dark ? .lightGray : .appBlackColor.withAlphaComponent(0.75) }
}

