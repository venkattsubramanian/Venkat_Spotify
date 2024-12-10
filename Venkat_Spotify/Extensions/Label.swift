//
//  createLabel.swift
//  Carspa
//
//  Created by Achu Anil's MacBook Pro on 10/06/24.
//

import Foundation
import UIKit

class createLabel {
    static func setLabel(font: UIFont, textColor: UIColor = .appBlackColor, textAlignment: NSTextAlignment = .left, text: String? = nil, noofLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        label.numberOfLines = noofLines
        return label
    }
}
