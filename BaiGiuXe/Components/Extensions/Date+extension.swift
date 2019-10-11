//
//  Date+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation

enum AppDateFormat: String {
    
    case ddMMMyyCommahhmma          = "dd MMM yyyy, hh:mm a"
    case ddMMMyyyySpacehhmma        = "dd MMM yyyy hh:mm a"
    case ddMMyyyyhhmmma             = "dd-MM-yyyy hh:mm"
    case ddMMMyyyy                  = "dd MMM yyyy"
    case ddMMyyyy                   = "dd MM yyyy"
    case MMyyyy                     = "MM yyyy"
    case MMMMyyyy                   = "MMMM yyyy"
    case hhmma                      =  "hh:mm a"
    case weekdayddMMMyyy            = "EE, dd MMM yyyy"
    case dd_MM_YYYY                 = "dd-MM-YYYY"
    case ddMMYYYY_VN                 = "dd/MM/YYYY"
    case ddMMYYYY_VNHHmm                 = "dd/MM/YYYY HH:mm"
    
    case MMMyyyy = "MMM yyyy"
    case ddMMYYYY = "dd.MM.YYYY"
    case yyyyMMdd = "yyyy-MM-dd"
    case HHmm = "HH:mm"
    case ha = "ha"
    
    var formatString: String {
        return self.rawValue
    }
}

extension Date {
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getNext30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 30, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
}

extension Date {
    func isSmaller(date: Date) -> Bool {
        let order = self.compare(date)
        return order == .orderedAscending
    }
    
    var isInThePast: Bool {
        let now = Date()
        return self.compare(now) == ComparisonResult.orderedAscending
    }
    
    func isSame(date: Date) -> Bool {
        let time1 = self.toBeginDay()
        let time2 = date.toBeginDay()
        let order = time1.compare(time2)
        
        return order == .orderedSame
    }
    
    func toMonthYear() -> (Int, Int) {
        var calendar        = Calendar.current
        let month   = calendar.component(.month, from: self)
        let year    = calendar.component(.year, from: self)
        
        return (month, year)
    }
    
    // 12/12/2017 12:12 -> 12/12/2017 00:01
    func toBeginDay() -> Date {
        let (month, year)       = self.toMonthYear()
        let day                 = Calendar.current.component(.day, from: self)
        let formmatter          = DateFormatter()
        formmatter.timeZone     = TimeZone(abbreviation: "UTC")
        formmatter.dateFormat   = AppDateFormat.ddMMyyyyhhmmma.rawValue
        
        guard let beginDate = formmatter.date(from: "\(day) \(month) \(year) 00:01") else { return Date()}
        
        return beginDate
    }
    
    /// SwifterSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    ///
    ///     Date().iso8601String -> "2017-01-12T14:51:29.574Z"
    ///
    public var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    /// SwifterSwift: Create date object from ISO8601 string.
    ///
    ///     let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    public init?(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }
    
    public init?(yyyyMMddHHmmss: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: yyyyMMddHHmmss) {
            self = date
        } else {
            return nil
        }
    }
    
    init?(gtFormat: String, gfFormat: AppDateFormat) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = gfFormat.formatString
        if let date = dateFormatter.date(from: gtFormat) {
            self = date
        } else {
            return nil
        }
    }
    
    public var isToday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInToday(self)
    }
    
    /**
     *  Determine if date is within the day tomorrow
     */
    public var isTomorrow: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInTomorrow(self)
    }
    
    /**
     *  Determine if date is within yesterday
     */
    public var isYesterday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInYesterday(self)
    }
    
    /**
     *  Determine if date is in a weekend
     */
    public var isWeekend: Bool {
        if weekday == 7 || weekday == 1 {
            return true
        }
        return false
    }
    
    // MARK: - Components
    
    /**
     *  Convenience getter for the date's `era` component
     */
    public var era: Int {
        return component(.era)
    }
    
    /**
     *  Convenience getter for the date's `year` component
     */
    public var year: Int {
        return component(.year)
    }
    
    /**
     *  Convenience getter for the date's `month` component
     */
    public var month: Int {
        return component(.month)
    }
    
    /**
     *  Convenience getter for the date's `week` component
     */
    public var week: Int {
        return component(.weekday)
    }
    
    /**
     *  Convenience getter for the date's `day` component
     */
    public var day: Int {
        return component(.day)
    }
    
    /**
     *  Convenience getter for the date's `hour` component
     */
    public var hour: Int {
        return component(.hour)
    }
    
    /**
     *  Convenience getter for the date's `minute` component
     */
    public var minute: Int {
        return component(.minute)
    }
    
    /**
     *  Convenience getter for the date's `second` component
     */
    public var second: Int {
        return component(.second)
    }
    
    /**
     *  Convenience getter for the date's `weekday` component
     */
    public var weekday: Int {
        return component(.weekday)
    }
    
    /**
     *  Convenience getter for the date's `weekdayOrdinal` component
     */
    public var weekdayOrdinal: Int {
        return component(.weekdayOrdinal)
    }
    
    /**
     *  Convenience getter for the date's `quarter` component
     */
    public var quarter: Int {
        return component(.quarter)
    }
    
    /**
     *  Convenience getter for the date's `weekOfYear` component
     */
    public var weekOfMonth: Int {
        return component(.weekOfMonth)
    }
    
    /**
     *  Convenience getter for the date's `weekOfYear` component
     */
    public var weekOfYear: Int {
        return component(.weekOfYear)
    }
    
    /**
     *  Convenience getter for the date's `yearForWeekOfYear` component
     */
    public var yearForWeekOfYear: Int {
        return component(.yearForWeekOfYear)
    }
    
    /**
     *  Convenience getter for the date's `daysInMonth` component
     */
    public var daysInMonth: Int {
        let calendar = Calendar.autoupdatingCurrent
        let days = calendar.range(of: .day, in: .month, for: self)
        return days!.count
    }
    
    public func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    func toString(dateFormat: AppDateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.formatString
        return dateFormatter.string(from: self)
    }
}
extension Date {
    func getNameOfDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        let dayInWeek = dateFormatter.string(from: self)
        
        switch dayInWeek {
        case "Monday":
            return "Thứ 2"
        case "Tuesday":
            return "Thứ 3"
        case "Wednesday":
            return "Thứ 4"
        case "Thursday":
            return "Thứ 5"
        case "Friday":
            return "Thứ 6"
        case "Saturday":
            return "Thứ 7"
        default:
            return "CN"
        }
    }
    
    func getIndexOfDay() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        let dayInWeek = dateFormatter.string(from: self)
        
        switch dayInWeek {
        case "Monday":
            return 0
        case "Tuesday":
            return 1
        case "Wednesday":
            return 2
        case "Thursday":
            return 3
        case "Friday":
            return 4
        case "Saturday":
            return 5
        default:
            return 6
        }
    }
}


extension Date {
    func timeAgo() -> String {
        let currentDate = Date()//.toLocalTime()
        let different = Calendar.current.dateComponents([.year, .month, .weekday, .day, .hour, .minute, .second], from: self, to: currentDate)
        
        if let year = different.year {
            if year > 0 {
                return "\(year) năm trước"
            }
            if let month = different.month {
                if month > 0 {
                    return  "\(month) tháng trước"
                }
            }
            
            if let week = different.weekday {
                if week > 0 {
                    return "\(week) tuần trước"
                }
            }
            
            if let day = different.day {
                if day > 0 {
                    return "\(day) ngày trước"
                }
            }
            
            if let hour = different.hour {
                if hour > 0 {
                    return "\(hour) giờ trước"
                }
            }
            
            if let minute = different.minute {
                if minute > 0 {
                    return "\(minute) phút trước"
                }
            }
            if let second = different.second {
                if second > 0 {
                    return "\(second) giây trước"
                }
            }
            
            return "Ngay bây giờ"
        }
        
        return ""
    }
}
