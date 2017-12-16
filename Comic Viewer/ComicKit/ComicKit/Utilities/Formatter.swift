//
//  Formatter.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

//
//  Formatter.swift
//  FlickrGallery
//
//  Created by Myles Eynon on 12/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

public class Formatter {
    
    static let trimmingCharacters = CharacterSet(charactersIn: " ,.*(^%$£@\"\'!")
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private static let mediumDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    private static let yearOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    private static let monthOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    private static let monthYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    private static let dayOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "cccc"
        return formatter
    }()
    
    
    private static let compactDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    private static let superCompactDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM/YY"
        return formatter
    }()
    
    private static let prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE, dd MMM yyyy"
        return formatter
    }()
    
    private static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter
    }()
    
    //2017-03-17T08:00:00Z
    private static let isoJsonDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"// "yyyy-MM-dd-HH-mm-ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    
    private static let isoJsonDateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    //ISO 8601
    private static let iso8601DateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"// "yyyy-MM-dd-HH-mm-ss"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        return dateFormatter
    }()
    
    private static let jsonDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    private static let sqlDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        //dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        return dateFormatter
    }()
    
    private static let sqliteDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        return dateFormatter
    }()
    
    private static let sqlServerDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        return dateFormatter
    }()
    
    private static let jsonDateOnlyFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        return dateFormatter
    }()
    
    private static let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumIntegerDigits = 1
        currencyFormatter.locale = Locale(identifier: "en_GB")
        return currencyFormatter
    }()
    
    private static let twoDecimalPlaceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private static let compactPlaceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    /** Formats the given duration in hours and minutes for display */
    class func duration(minutes: Int) -> String {
        
        guard minutes > 0 else { return String() }
        
        let minutesToHoursMinutes = { (minutes: Int) -> (Int, Int) in
            return (minutes / 60, minutes % 60)
        }
        
        let (h,m) = minutesToHoursMinutes(minutes)
        let hrs = h < 2 ? NSLocalizedString("hr", comment: "hr") : NSLocalizedString("hrs", comment: "hrs")
        let mins = m < 2 ? NSLocalizedString("min", comment: "min") : NSLocalizedString("mins", comment: "mins")
        
        var strings = [String]()
        
        switch (h,m) {
        case (0,0...4):
            strings.append("< 5")
            strings.append(mins)
        case (0,0...59):
            strings.append("\(m)")
            strings.append(mins)
        case (0...Int.max,0):
            strings.append("\(h)")
            strings.append(hrs)
        case (0...Int.max,0...59):
            strings.append("\(h)")
            strings.append(hrs)
            strings.append(" \(m)")
            strings.append(mins)
            
        default:
            break
        }
        
        return strings.joined()
    }
    
    /** Formats the given duration in hours and minutes for display */
    public class func duration(seconds: Int) -> String {
        
        guard seconds > 0 else { return "< 1min" }
        
        let secondsToHoursMinutesSeconds = { (seconds: Int) -> (Int, Int, Int) in
            return (seconds / 3600, seconds / 60, seconds % 60)
        }
        
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds)
        
        let hrs = h < 2 ? NSLocalizedString("hr", comment: "hr") : NSLocalizedString("hrs", comment: "hrs")
        let mins = m < 2 ? NSLocalizedString("min", comment: "min") : NSLocalizedString("mins", comment: "mins")
        //let secs = "s"
        
        var strings = [String]()
        
        switch (h,m,s) {
            //        case (0, 0, 0...4):
            //            strings.append("< 5")
        //            strings.append(secs)
        case (0, 0, 0...59):
            strings.append("< 1")
            strings.append(mins)
            //        case (0, 0...4, 0...Int.max):
            //            strings.append("< 5")
        //            strings.append(mins)
        case (0, 0...59, 0...Int.max):
            strings.append("\(m)")
            strings.append(mins)
        case (0...Int.max, 0, 0...Int.max):
            strings.append("\(h)")
            strings.append(hrs)
        case (0...Int.max, 0...59, 0...Int.max):
            strings.append("\(h)")
            strings.append(hrs)
            strings.append(" \(m)")
            strings.append(mins)
            
        default:
            break
        }
        
        return strings.joined()
    }
    
    
    private enum secondsInCalendarUnit: Double {
        case minute = 60
        case hour = 3600
        case day = 86400
        case week = 604800
        case month = 2419200 //18144000
        case year = 31536000
        
        func toInt(_ value: TimeInterval) -> Int {
            return Int(floor(value / self.rawValue))
        }
        func isLessThan(_ value: TimeInterval) -> Bool {
            return value < self.rawValue
        }
        
        static func closest(_ toValue: TimeInterval) ->secondsInCalendarUnit {
            
            if let result = secondsInCalendarUnit.getClosest(value: .minute, to: toValue) {
                return result
            }
            
            if let result = secondsInCalendarUnit.getClosest(value: .hour, to: toValue) {
                return result
            }
            
            if let result = secondsInCalendarUnit.getClosest(value: .day, to: toValue) {
                return result
            }
            
            if let result = secondsInCalendarUnit.getClosest(value: .week, to: toValue) {
                return result
            }
            
            if let result = secondsInCalendarUnit.getClosest(value: .month, to: toValue) {
                return result
            }
            
            return .year
        }
        
        static func getClosest(value:secondsInCalendarUnit, to: TimeInterval) -> secondsInCalendarUnit? {
            if value.isLessThan(to) {
                return value
            }
            return nil
        }
        
    }
    
    
    
    /** Formats time as HH:MM for display */
    public class func hoursAndMinutes(dateTime: Date) -> String {
        //"12:59"
        return timeFormatter.string(from: dateTime)
    }
    
    /** Formats given date as 'DD/MM/YYYY'  */
    public class func compactDate(date: Date) -> String {
        //"23/10/2015"
        return compactDateFormatter.string(from: date)
    }
    
    /** Formats given date as 'MM/YY'  */
    public class func superCompactDate(date: Date) -> String {
        //"23/10/2015"
        return superCompactDateFormatter.string(from: date)
    }
    
    /** Formats given date as 'MONTH'  */
    public class func monthOnlyDate(date: Date) -> String {
        //"December" in localized language
        return monthOnlyDateFormatter.string(from: date)
    }
    
    /** Formats given date as 'DAY'  */
    public class func dayOnlyDate(date: Date) -> String {
        //"Monday" in localized language
        return dayOnlyDateFormatter.string(from: date)
    }
    
    /** Formats given date as 'yyyy'  */
    public class func yearOnlyDate(date: Date) -> String {
        //"December" in localized language
        return yearOnlyDateFormatter.string(from: date)
    }
    
    /** Formats given date as 'MONTH' 'yyyy'  */
    public class func monthYearDate(date: Date) -> String {
        //"December" in localized language
        return monthYearDateFormatter.string(from: date)
    }
    
    /** Gets a nicely formatted time as Mon, 01 Jan 2017 */
    public class func prettyDate(date: Date) -> String {
        return prettyDateFormatter.string(from: date)
    }
    
    /** Formats given date as 'MONDAY, 23rd MARCH 2017'  */
    public class func fullDate(date: Date) -> String {
        //"23/10/2015"
        return fullDateFormatter.string(from: date)
    }
    
    /** Converts a json date into a date */
    public class func dateFrom(json: String) -> Date? {
        return jsonDateFormatter.date(from: json)
    }
    
    /** Converts a json date into a date */
    public class func isoDateFrom(json: String) -> Date? {
        return isoJsonDateFormatter.date(from: json)
    }
    
    /** Converts a json date into a date */
    public class func iso2DateFrom(json: String) -> Date? {
        return isoJsonDateFormatter2.date(from: json)
    }
    
    /** Converts a json date into a date */
    public class func iso8601DateFrom(json: String) -> Date? {
        return iso8601DateFormatter.date(from: json)
    }
    
    /** Converts a json date into a date */
    public class func sqliteDateString(date: Date) -> String {
        return sqliteDateFormatter.string(from: date)
    }
    
    /** Converts a json date into a date */
    public class func sqlServerDateString(json: String) -> Date? {
        return sqlServerDateFormatter.date(from: json)
    }
    
    /** Converts a json date into a string */
    public class func iso8601DateFrom(date: Date) -> String {
        return iso8601DateFormatter.string(from: date)
    }
    
    
    /** Converts a json date only into a date. Trims length to yyyy-MM-dd before attempting to convert. */
    public class func dateOnlyFrom(json: String) -> Date? {
        let len = 10
        if json.count > len {
            let index = json.index(json.startIndex, offsetBy: len)
            return jsonDateOnlyFormatter.date(from: String(json[json.startIndex...index]))
        }
        return nil
    }
    
    /** Gets a json string version of the given date */
    public class func jsonDate(fromDate: Date?) -> String {
        guard let date = fromDate else { return String() }
        return jsonDateFormatter.string(from: date)
    }
    
    /** Gets a json string version of the given date */
    public class func jsonDateOnly(fromDate: Date?) -> String {
        guard let date = fromDate else { return String() }
        return jsonDateOnlyFormatter.string(from: date)
    }
    
    /** Gets a json string version of the given date */
    public class func sqlDateString(fromDate: Date?) -> String {
        guard let date = fromDate else { return String() }
        return sqlDateFormatter.string(from: date)
    }
    
    
    /** Formats a value with the current currency to two decimal places */
    public class func currency(_ value: Double) -> String {
        return currencyFormatter.string(for: value)!
    }
    
    /** The currency symbol in use */
    public class func currencySymbol() -> String {
        return currencyFormatter.currencySymbol
    }
    
    /** Format value as 0.00 */
    public class func twoDecimalPlaces(_ value: Double) -> String {
        return twoDecimalPlaceFormatter.string(for: value)!
    }
}




