//
//  File.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/1/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit
import Foundation

public class CODateFormatter: NSObject {
    
    public static var currentCalendar: Calendar {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.firstWeekday = 1
        
        return calendar
    }
    
    public static func slashSeparatorDateFormatter(input: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: input) {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE HH:mm"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
        
        public static var onlyWeekdayDateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            
            return dateFormatter
        }
}
