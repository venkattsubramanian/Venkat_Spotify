//
//  Font.swift
//  Carspa
//
//  Created by Ait iMac 02 on 15/04/24.
//

import UIKit

extension UIFont {
    
    static func primaryFont(size:CGFloat = 20.0) -> UIFont{
        return UIFont(name: "AzoSans-Bold", size: .aspectWidth(size))!
    }
    
    static func primaryMediumFont(size:CGFloat = 18.0) -> UIFont{
        return UIFont(name: "AzoSans-Medium", size: .aspectWidth(size))!
    }
    
    static func primarySmallFont(size:CGFloat = 15.0) -> UIFont{
        return UIFont(name: "AzoSans-Light", size: .aspectWidth(size))!
    }
}
