//
//  LoadingCollectionViewCell.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit
import ComicKit

class LoadingCollectionViewCell: UICollectionViewCell, RegisterableCollectionViewCell {
    
    // MARK: Constants
    
    static var identifier: String {
        return String(describing: LoadingCollectionViewCell.self)
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.spinner.startAnimating()
    }
    
}

