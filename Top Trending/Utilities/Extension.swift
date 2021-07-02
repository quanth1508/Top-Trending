//
//  Extension.swift
//  Top Trending
//
//  Created by Quan Tran on 30/06/2021.
//

import Foundation

extension Date {
    
    // custom date time ago publish at video
    var since: String {
        get {
            let start = self
            let end = Date()
            
            let components = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: start, to: end)
            
            var significance: String = ""
            if let years = components.year, years > 0 {
                significance = years == 1 ? "\(years) năm" : "\(years) năm"
            }
            else if let months = components.month, months > 0 {
                significance = months == 1 ? "\(months) tháng" : "\(months) tháng"
            }
            else if let weeks = components.weekOfYear, weeks > 0 {
                significance = weeks == 1 ? "\(weeks) tuần" : "\(weeks) tuần"
            }
            else if let days = components.day, days > 0 {
                significance = days == 1 ? "\(days) ngày" : "\(days) ngày"
            }
            else if let hours = components.hour, hours > 0 {
                significance = hours == 1 ? "\(hours) giờ" : "\(hours) giờ"
            }
            else if let minutes = components.minute, minutes > 0 {
                significance = minutes == 1 ? "\(minutes) phút" : "\(minutes) phút"
            }
            else if let seconds = components.second, seconds > 0 {
                significance = seconds == 1 ? "\(seconds) giây" : "\(seconds) giây"
            }
            return "\(significance) trước"
        }
    }
}

extension Int {
    
    func toNumberViews() -> String {
        let number = Double(self)
        
        var resultFormat = ""
        
        if number < 1000 {
            resultFormat = "\(Int(number))"
        } else if number == 1000 {
            resultFormat = "1N"
        }else if number > 1000 && number <= 9949 {
            let ans = Double(round((number / 1000) * 10) / 10)
            resultFormat = "\(ans)N"
        } else if number > 9949 && number <= 999499 {
            let ans = Int(round((number / 1000) * 1) / 1)
            resultFormat = "\(ans-1)N"
        } else if number > 999499 && number <= 9949999 {
            if number <= 1049999 {
                resultFormat = "1Tr"
            } else {
                let ans = Double(round((number / 1000000) * 10) / 10)
                resultFormat = "\(ans)Tr"
            }
        } else if number > 9949999 && number <= 999499999 {
            let ans = Int(round((number / 1000000) * 1) / 1)
            resultFormat = "\(ans-1)Tr"
        } else if number > 999500000 && number <= 9949999999 {
            if number < 1049999999 {
                resultFormat = "1T"
            } else {
                let ans = Double(round((number / 1000000000) * 10) / 10)
                resultFormat = "\(ans)T"
            }
        } else {
            let ans = Int(round((number / 1000000000) * 1) / 1)
            resultFormat = "\(ans)T"
        }
        return resultFormat
    }
}
