//
//  ComicCollectionViewDataSource.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit
import ComicKit

class ComicCollectionViewDataSource: ComicDataSource, CollectionViewDataSource {
    
    //MARK: Constants
    
    let comicSection: Int = 0
    let loadingSection: Int = 1
    let noComicSection: Int = 2
    
    //MARK: Methods
    
    init(withCollectionView collectionView: UICollectionView) {
        super.init()
        self.registerCells(withCollectionView: collectionView)
    }
    
    public func numberOfSections() -> Int {
        return 3
    }
    
    public func numberOfRows(inSection section: Int) -> Int {
        switch section {
        case comicSection:
            return self.viewModels.count
        case loadingSection:
            return self.isLoading ? 1 : 0
        case noComicSection:
            return self.viewModels.count == 0 && !self.isLoading ? 1 : 0
        default:
            return 0
        }
    }
    
    public func registerCells(withCollectionView collectionView: UICollectionView) {
        LoadingCollectionViewCell.register(collectionView)
        NoComicsCollectionViewCell.register(collectionView)
        ComicCollectionViewCell.register(collectionView)
    }
    
    public func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        switch indexPath.section {
        case comicSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier, for: indexPath) as! ComicCollectionViewCell
            cell.update(withViewModel: self.viewModels[indexPath.row])
            return cell
            
        case noComicSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoComicsCollectionViewCell.identifier, for: indexPath) as! NoComicsCollectionViewCell
            cell.delegate = self
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.identifier, for: indexPath) as! LoadingCollectionViewCell
            return cell
        }
    }
    
    public func sizeForCell(atIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> CGSize {
        switch indexPath.section {
        case comicSection:
            let comicAspect: CGFloat = 1.5
            let rows: CGFloat = 4.0
            let comicHeight = (collectionView.bounds.height - 112) / rows
            return CGSize(width: comicHeight / comicAspect, height: comicHeight)
        case loadingSection:
            if self.viewModels.count > 0 {
                return CGSize(width: 60.0, height: collectionView.bounds.size.height)
            } else {
                return collectionView.bounds.size
            }
        default:
            return collectionView.bounds.size
        }
    }
    
    public func minimumLineSpacing(forSection section: Int, collectionView: UICollectionView) -> CGFloat {
        switch section {
        case comicSection:
            return 14.0
        default:
            return 0
        }
    }
    
    public func interimSpacing(forSection section: Int, collectionView: UICollectionView) -> CGFloat {
        switch section {
        case comicSection:
            return  14.0
        default:
            return 0
        }
    }
    
    public func inset(forSection section: Int, collectionView: UICollectionView) -> UIEdgeInsets {
        switch section {
        case comicSection:
            if self.viewModels.count > 0 {
                return UIEdgeInsets(top: 40.0, left: 30.0, bottom: 30.0, right: 10.0)
            }
            return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        default:
            return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    public func willDisplayCell(atIndexPath indexPath: IndexPath, cell: UICollectionViewCell, collectionView: UICollectionView) {
        
        if indexPath.section == self.comicSection && indexPath.row == (self.viewModels.count - 1) && !self.hasReachedLastPage {
            // Check scrolled percentage
            let xOffset = collectionView.contentOffset.x
            let width = collectionView.contentSize.width - collectionView.frame.size.width
            let scrolledPercentage = xOffset / width
            
            // Check if all the conditions are met to allow loading the next page
            if scrolledPercentage > 0.3 {
                debugPrint("Grabbing more comics")
                // This is the bottom of the table view, load more data here.
                self.reload()
            }
        } else if let loadingCell = cell as? LoadingCollectionViewCell {
            loadingCell.spinner.startAnimating()
        }
    }
    
    public func shouldHighlightItem(atIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> Bool {
        if indexPath.section == loadingSection {
            return false
        }
        
        if self.viewModels.count == 0 {
            return false
        }
        
        return true
    }
}

// MARK: NoComicsCollectionViewCellDelegate

extension ComicCollectionViewDataSource: NoComicsCollectionViewCellDelegate {
    
    func noComicsCollectionViewCellRetryPressed(_ cell: NoComicsCollectionViewCell) {
        self.reload()
    }
}
