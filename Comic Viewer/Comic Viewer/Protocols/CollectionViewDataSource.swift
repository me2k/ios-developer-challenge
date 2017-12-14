//
//  CollectionViewDataSource.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

protocol CollectionViewDataSource {
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func registerCells(withCollectionView collectionView: UICollectionView)
    func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell
    func willDisplayCell(atIndexPath indexPath: IndexPath, cell: UICollectionViewCell, collectionView: UICollectionView)
    func shouldHighlightItem(atIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> Bool
    
    func sizeForCell(atIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> CGSize
    func interimSpacing(forSection section: Int, collectionView: UICollectionView) -> CGFloat
    func minimumLineSpacing(forSection section: Int, collectionView: UICollectionView) -> CGFloat
    func inset(forSection section: Int, collectionView: UICollectionView) -> UIEdgeInsets

}
