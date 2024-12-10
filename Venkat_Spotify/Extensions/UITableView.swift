//
//  UITableView.swift
//  Carspa
//
//  Created by Achu Anil's MacBook Pro on 15/11/24.
//

import Foundation
import UIKit

extension UITableView {
    func reloadData(withAnimation animation: UITableView.RowAnimation = .fade) {
        self.reloadData()
        let cells = self.visibleCells
        slideInFromLeftAnimation(for: cells)
    }
    
    func slideInFromLeftAnimation(for cells: [UITableViewCell]) {
        let tableViewWidth = self.bounds.size.width
        for cell in cells {
            if cell is NoNotificationTableViewCell {
                continue
            }
            cell.transform = CGAffineTransform(translationX: -tableViewWidth, y: 0)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 0.4, delay: 0.05 * Double(delayCounter), options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
