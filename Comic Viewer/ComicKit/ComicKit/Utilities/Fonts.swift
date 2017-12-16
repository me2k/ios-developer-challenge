//
//  Fonts.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//


import UIKit

public enum Fonts {
    
    public enum Weight {
        
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
        
        private static let fontNameRegular = "AmericanTypewriter"
        private static let fontNameBold = "AmericanTypewriter-Bold"
        private static let fontNameMedium = "AmericanTypewriter-Semibold"
        private static let fontNameLight = "AmericanTypewriter-Light"
        private static let fontNameSemibold = "AmericanTypewriter-Semibold"
        
        public var weightValue: UIFont.Weight {
            switch self {
            case .ultraLight:
                return UIFont.Weight.ultraLight
            case .thin:
                return UIFont.Weight.thin
            case .light:
                return UIFont.Weight.light
            case .regular:
                return UIFont.Weight.regular
            case .medium:
                return UIFont.Weight.medium
            case .semibold:
                return UIFont.Weight.semibold
            case .bold:
                return UIFont.Weight.bold
            case .heavy:
                return UIFont.Weight.heavy
            case .black:
                return UIFont.Weight.black
            }
        }
        
        public var fontName: String {
            switch self {
            case .light:
                return Weight.fontNameLight
            case .regular:
                return Weight.fontNameRegular
            case .medium:
                return Weight.fontNameMedium
            case .semibold:
                return Weight.fontNameSemibold
            case .bold:
                return Weight.fontNameBold
            default:
                return Weight.fontNameRegular
            }
        }
    }
    
    /** Use the given font or use the system font as the base font*/
    private static let useSystemFont = true
    
    case nano(Weight?)
    case extraTinyHalf(Weight?)
    case nanoHalf(Weight?)
    case extraTiny(Weight?)
    case tiny(Weight?)
    case extraSmallHalf(Weight?)
    case extraSmall(Weight?)
    case smallHalf(Weight?)
    case small(Weight?)
    case standard(Weight?)
    case regularHalf(Weight?)
    case regular(Weight?)
    case largeHalf(Weight?)
    case large(Weight?)
    case grande(Weight?)
    case superGrande(Weight?)
    case enormay(Weight?)
    case whooper(Weight?)
    
    private static let nanoSize:CGFloat = 8
    private static let nanoHalfSize:CGFloat = 8.5
    private static let extraTinyHalfSize:CGFloat = 8.5
    private static let extraTinySize:CGFloat = 9
    private static let tinySize:CGFloat = 10
    private static let extraSmallHalfSize:CGFloat = 11
    private static let extraSmallSize:CGFloat = 12
    private static let smallHalfSize:CGFloat = 13
    private static let smallSize:CGFloat = 14
    private static let standardSize:CGFloat = 15
    private static let regularHalfSize:CGFloat = 16
    private static let regularSize:CGFloat = 17
    private static let largeHalfSize:CGFloat = 18
    private static let largeSize:CGFloat = 20
    private static let grandeSize:CGFloat = 24
    private static let superGrandeSize:CGFloat = 26
    private static let enormaySize: CGFloat = 40
    private static let whooperSize: CGFloat = 90
    
    private var size: CGFloat {
        
        var fontSize: CGFloat = Fonts.regularSize
        
        switch self {
        case .nano:
            fontSize = Fonts.nanoSize
        case .nanoHalf:
            fontSize = Fonts.nanoHalfSize
        case .extraTiny:
            fontSize = Fonts.extraTinySize
        case .extraTinyHalf:
            fontSize = Fonts.extraTinyHalfSize
        case .tiny:
            fontSize = Fonts.tinySize
        case .extraSmallHalf:
            fontSize = Fonts.extraSmallHalfSize
        case .extraSmall:
            fontSize = Fonts.extraSmallSize
        case .smallHalf:
            fontSize = Fonts.smallHalfSize
        case .small:
            fontSize = Fonts.smallSize
        case .standard:
            fontSize = Fonts.standardSize
        case .regularHalf:
            fontSize = Fonts.regularHalfSize
        case .regular:
            fontSize = Fonts.regularSize
        case .largeHalf:
            fontSize = Fonts.largeHalfSize
        case .large:
            fontSize = Fonts.largeSize
        case .grande:
            fontSize = Fonts.grandeSize
        case .superGrande:
            fontSize = Fonts.superGrandeSize
        case .enormay:
            fontSize = Fonts.enormaySize
        case .whooper:
            fontSize = Fonts.whooperSize
        }
        return fontSize
    }
    
    private var weightValue: Weight {
        switch self {
        case .nano(let weight):
            return weight ?? .regular
        case .nanoHalf(let weight):
            return weight ?? .regular
        case .extraTiny(let weight):
            return weight ?? .regular
        case .extraTinyHalf(let weight):
            return weight ?? .regular
        case .tiny(let weight):
            return weight ?? .regular
        case .extraSmallHalf(let weight):
            return weight ?? .regular
        case .extraSmall(let weight):
            return weight ?? .regular
        case .smallHalf(let weight):
            return weight ?? .regular
        case .small(let weight):
            return weight ?? .regular
        case .standard(let weight):
            return weight ?? .regular
        case .regularHalf(let weight):
            return weight ?? .regular
        case .regular(let weight):
            return weight ?? .regular
        case .largeHalf(let weight):
            return weight ?? .regular
        case .large(let weight):
            return weight ?? .regular
        case .grande(let weight):
            return weight ?? .regular
        case .superGrande(let weight):
            return weight ?? .regular
        case .enormay(let weight):
            return weight ?? .regular
        case .whooper(let weight):
            return weight ?? .regular
        }
    }
    
    public var font: UIFont {
        return Fonts.useSystemFont ? UIFont.systemFont(ofSize: self.size, weight: self.weightValue.weightValue) : UIFont(name: self.weightValue.fontName, size: self.size)!
    }
}

