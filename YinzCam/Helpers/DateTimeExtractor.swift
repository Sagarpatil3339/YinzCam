//
//  DateTimeExtractor.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/20/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation

/* For getting time and date of each match from timestamp which is in ISO8601DateFormatter and convert in Desired Format
 */

// For assigning Days and Months as strings to WeekDay from Date Component
enum WeekDay: String, CaseIterable {
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
    static var weekDayArray: [WeekDay] {return self.allCases}
}
enum Month: String, CaseIterable {
    case Jan, Feb, Mar, Apr, May, June, July, Aug, Sep, Oct, Nov, Dec
    static var monthArray: [Month] {return self.allCases}
}

class DateTimeExtractor {
    
    var time : String = ""
    var date : String = ""
    
    init(Timestamp: String) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
        ]
        if let date = dateFormatter.date(from: Timestamp) {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let weekDay = WeekDay.weekDayArray[calendar.component(.weekday, from: date)-1]
            let month = Month.monthArray[calendar.component(.month, from: date)-1]
            self.date = "\(weekDay), \(month) \(day)"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            self.time = formatter.string(from: date)
        }
    }
}
