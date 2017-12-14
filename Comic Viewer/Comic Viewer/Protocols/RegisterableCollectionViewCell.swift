//
//  RegisterableCollectionViewCell.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

protocol RegisterableCollectionViewCell {
    
    /** reuse identifier and nib name */
    static var identifier: String { get }
}

extension RegisterableCollectionViewCell {
    
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: self.identifier, bundle: nil), forCellWithReuseIdentifier: self.identifier)
    }
}

