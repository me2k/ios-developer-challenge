//
//  ComicCollectionViewCell.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit
import AlamofireImage
import ComicKit

class ComicCollectionViewCell: UICollectionViewCell, RegisterableCollectionViewCell {

    //MARK: Constants
    
    static var identifier: String {
        return String(describing: ComicCollectionViewCell.self)
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reset()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.imageView.af_cancelImageRequest()
        self.imageView.image = #imageLiteral(resourceName: "comicholder")
    }
    
    func update(withViewModel viewModel: ComicViewModel) {
        if let mediaUrl = viewModel.thumbnailImageURL {
            self.imageView.af_setImage(withURL: mediaUrl, placeholderImage: #imageLiteral(resourceName: "comicholder"))
        }
    }
}
