//
//  UIViewcontroller.swift
//  Carspa
//
//  Created by Achu Anil's MacBook Pro on 25/04/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, buttonTitle: String = "OK", buttonAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            buttonAction?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension UIViewController {
    func presentAlert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, handler: (() -> Void)?)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.handler?()
            }
            alert.addAction(alertAction)
        }
        present(alert, animated: true)
    }
}
