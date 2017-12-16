//
//  ComicDetailViewController.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit
import AlamofireImage
import ComicKit

class ComicDetailViewController: UIViewController, IHasComicViewModel, IHasComicDataSource {
    
    //MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var comicImageView: UIImageView!
    
    //MARK: Properties
    
    var viewModel: ComicViewModel!
    var dataSource: ComicDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp(withComicViewModel: self.viewModel)
    }

    func setUp(withComicViewModel comicViewModel: ComicViewModel) {
        self.viewModel = comicViewModel
        self.setComicImage()
        self.populateScrollView()
    }
    
    @IBAction func homePressed(withSender sender: Any?) {
        self.dismiss(animated: true)
    }

    func setComicImage() {
        guard let imageUrl = viewModel.detailImageURL else {
            self.comicImageView.image = #imageLiteral(resourceName: "comicholder")
            return
        }
        self.comicImageView.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "comicholder"))
    }
    
    func populateScrollView() {
        self.scrollView.subviews.forEach({ $0.removeFromSuperview() })
        guard viewModel != nil else {
            return
        }
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(label)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[label(==\(UIScreen.main.bounds.width - 32.0))]-16-|", options: [], metrics: nil, views: ["label" : label])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[label]-16-|", options: [], metrics: nil, views: ["label" : label])
        scrollView.addConstraints(horizontalConstraints)
        scrollView.addConstraints(verticalConstraints)
        
        //use attributed strings.
        
        let titleAttributedString = viewModel.title?.toAttributedString(withColour: .black, andFont: .regular(.semibold))
        let descriptionAttributedString = viewModel.itemDescription?.toAttributedString(withColour: .black, andFont: .small(.regular))
        let charactersAttributedString = viewModel.characters?.toAttributedString(withColour: .black, andFont: .small(.regular))
        let newLineAttributedString = "\n".toAttributedString(withColour: .black, andFont: .small(.regular))
        
        let combinedText = NSMutableAttributedString()
        
        if let title = titleAttributedString {
            combinedText.append(title)
            combinedText.append(newLineAttributedString)
        }
        if let descriptionString = descriptionAttributedString {
            combinedText.append(descriptionString)
            combinedText.append(newLineAttributedString)
        }
        if let characters = charactersAttributedString {
            combinedText.append(characters)
        }
        label.attributedText = combinedText
    }

    @IBAction func loadPreviousComic(withSender sender: Any?) {
        guard let previousComic = dataSource.getPreviousComic(withComicVM: self.viewModel) else { return }
        self.setUp(withComicViewModel: previousComic)
    }
    
    
    @IBAction func loadNextComic(withSender sender: Any?) {
        guard let nextComic = dataSource.getNextComic(withComicVM: self.viewModel) else { return }
        self.setUp(withComicViewModel: nextComic)
    }
}
