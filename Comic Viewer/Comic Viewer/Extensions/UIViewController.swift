//
//  UIViewController.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

extension UIViewController {
    /** Performs a segue */
    func performSegue(_ withIdentifier: SegueIdentifiers, sender: Any? = nil) {
        self.performSegue(withIdentifier: withIdentifier.rawValue, sender: sender)
    }
}
