////
////  CalenderHelper.swift
////  Lunaris
////
////  Created by Münevver Elif Ay on 11.04.2023.
////
//
//import Foundation
//import UIKit
//
//class CalenderHelper {
//    
//    let calender = Calendar.current
//    
//    func plusMonth(date: Date) -> Date {
//        return calender.date(byAdding: .month, value: 1, to: date)!
//    }
//    
//    func minusMonth(date: Date) -> Date {
//        return calender.date(byAdding: .month, value: 1, to: date)!
//    }
//    
//    func monthString(date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "LLLL"
//        return dateFormatter.string(from: date)
//    }
//    
//    func yearString(date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy"
//        return dateFormatter.string(from: date)
//    }
//    
//    func dayInMonth(date: Date) -> Int {
//        let range = calender.range(of: .day, in: .month, for: date)!
//        return range.count
//    }
//    
//    func dayOfMonth(date: Date) -> Int {
//        let components = calender.dateComponents([.day], from: date)
//        return components.day!
//    }
//    
//    func firstOfMonth(date: Date) -> Date {
//        let components = calender.dateComponents([.year, .month], from: date)
//        return calender.date(from: components)!
//    }
//    
//    func weekDay(date: Date) -> Int {
//        let components = calender.dateComponents([.weekday], from: date)
//        return components.weekday! - 1
//    }
//
//}
