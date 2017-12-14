//
//  NoComicsCollectionViewCell.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

protocol NoComicsCollectionViewCellDelegate {
    func noComicsCollectionViewCellRetryPressed(_ cell: NoComicsCollectionViewCell)
}

class NoComicsCollectionViewCell: UICollectionViewCell, RegisterableCollectionViewCell {
    
    // MARK: Constants
    
    class var identifier: String {
        return String(describing: NoComicsCollectionViewCell.self)
    }
    
    // MARK: Properties
    
    var delegate: NoComicsCollectionViewCellDelegate?
    
    // MARK: Outlets
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var retryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        setUp()
    }
    
    func setUp() {
        retryLabel.text = NSLocalizedString("no_comics_cell_title", value: "Unable to get comics", comment: "No comics cell title")
        retryButton.setTitle(NSLocalizedString("no_comics_cell_retry_button_title", value: "Try Again", comment: "No Comics try again button title"), for: .normal)
    }
    
    @IBAction func retryPressed(withSender sender: UIButton) {
        self.delegate?.noComicsCollectionViewCellRetryPressed(self)
    }
}
