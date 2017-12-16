//
//  String.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

/** Decorators for strings */
public extension String {
    
    // MARK: Initialisers
    
    init?(htmlEncodedString: String) {
        if let encodedData = htmlEncodedString.data(using: String.Encoding.utf8) {
            let attributedOptions : [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            var attributedString = NSAttributedString(string: htmlEncodedString)
            do {
                attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            } catch {
                debugPrint("Error Decoding html string: \(attributedString)")
            }
            self.init(attributedString.string)
        } else {
            self.init(htmlEncodedString)
        }
    }
    
    //MARK: Instance methods
    
    /** Creates attributed string from self */
    func toAttributedString() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    /** Creates attributed string of self with given colour and font */
    func toAttributedString(withColour colour: UIColor, andFont font: Fonts? = .regular(.regular)) -> NSAttributedString {
        
        var attributes = [NSAttributedStringKey : Any]()
        
        attributes[.foregroundColor] = colour
        
        if let font = font {
            attributes[.font] = font.font
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
}

public extension NSAttributedString {
    
    func toMutableAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.width
    }
    
}


