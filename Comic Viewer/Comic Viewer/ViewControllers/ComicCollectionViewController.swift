//
//  ComicCollectionViewController.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit
import ComicKit

class ComicCollectionViewController: UICollectionViewController {

    // MARK: Properties
    
    var dataSource: ComicCollectionViewDataSource!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "galaxy-iphone-wallpaper-36"))
        self.collectionView?.backgroundColor = .clear
        dataSource = ComicCollectionViewDataSource(withCollectionView: self.collectionView!)
        dataSource.delegate = self
        dataSource.reload()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController, var destinationVC = navVC.viewControllers.first as? IHasComicViewModel, let viewModel = sender as? ComicViewModel {
            destinationVC.viewModel = viewModel
        }
        
        if let navVC = segue.destination as? UINavigationController, var destinationVC = navVC.viewControllers.first as? IHasComicDataSource {
            destinationVC.dataSource = self.dataSource
        }
    }
 
    func reloadCollectionView() {
        self.collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRows(inSection: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource.cellForRow(atIndexPath: indexPath, collectionView: collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(.showComicDetailViewController, sender: dataSource.viewModels[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dataSource.willDisplayCell(atIndexPath: indexPath, cell: cell, collectionView: collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return dataSource.shouldHighlightItem(atIndexPath: indexPath, collectionView: collectionView)
    }
}

// MARK: DataSourceDelegate

extension ComicCollectionViewController: DataSourceDelegate {
    
    func dataSourceDidStartUpdate(dataSource: DataSourceProtocol) {
        self.reloadCollectionView()
    }
    
    func dataSourceDidUpdate(dataSource: DataSourceProtocol) {
        self.reloadCollectionView()
    }
    
    func dataSourceDidFailToUpdate(error: Error?, httpCode: Int?, dataSource: DataSourceProtocol) {
        self.reloadCollectionView()
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ComicCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.sizeForCell(atIndexPath: indexPath, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.interimSpacing(forSection: section, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.minimumLineSpacing(forSection: section, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return dataSource.inset(forSection: section, collectionView: collectionView)
    }
}

