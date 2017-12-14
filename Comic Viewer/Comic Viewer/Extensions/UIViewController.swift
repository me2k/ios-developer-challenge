//
//  UIViewController.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /** Shows an alert message with a default OK button */
    func showAlert(title: String?, message: String?, okTitle: String = "OK", okHandler: ((_ alertAction: UIAlertAction) -> Void)? = nil) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: okTitle, style: .default, handler: okHandler))
        if self.view.superview != nil {
            self.present(alertView, animated: true, completion: nil)
        } else {
            debugPrint("Unable to show UI ALERT as this view is not on the heirarchy: \(message ?? "")")
        }
    }
    
    /** Performs a segue */
    func performSegue(_ withIdentifier: SegueIdentifiers, sender: Any? = nil) {
        self.performSegue(withIdentifier: withIdentifier.rawValue, sender: sender)
    }
}
