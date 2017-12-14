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
    
    //MARK: Static methods
    
    
    /** Determines if the string is nil or empty */
    static func isNilOrEmpty(_ input: String?) -> Bool {
        guard let input = input else { return true }
        return input.isEmpty
    }
    
    /**
     Returns a new line
     - returns: String
     */
    static func newLine(_ numberOfLines: Int = 1) -> String {
        let lineBreak: Character = "\r"
        return String(repeating: String(lineBreak), count: numberOfLines)
    }
    
    
    static var whiteSpace: String {
        return " "
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
            attributes[.font] = font.noScaleFont
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    /** Removes whitespace from begining and end of string */
    func trim(withCharacterSet characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        let trimmed = self.trimmingCharacters(in: characterSet)
        return trimmed
    }
    
    /**
     Does the receiver start with the given string?
     - returns: True if it does
     */
    func starts(with input: String) -> Bool {
        guard let range = range(of: input, options: [.caseInsensitive]) else {
            return false
        }
        return range.lowerBound == startIndex
    }
}

infix operator =^=
/** A case insensitive comparision */
public func =^= (left: String?, right: String) -> Bool {
    guard let left = left else { return false }
    return left.caseInsensitiveCompare(right) == ComparisonResult.orderedSame
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

public extension NSMutableAttributedString {
    
    func add(colour: UIColor, andFont font: Fonts? = nil) {
        
        let range = NSMakeRange(0, self.length)
        self.addAttribute(.foregroundColor, value: colour, range: range)
        
        if let font = font {
            self.addAttribute(.font, value: font.font, range: range)
        }
    }
    
    /** Replace the colour for the whole string */
    func replace(colour: UIColor) {
        
        let range = NSMakeRange(0, self.length)
        self.removeAttribute(.foregroundColor, range: range)
        self.add(colour: colour)
    }
}


