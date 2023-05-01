////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import Foundation
import UIKit

class Utilities: NSObject {
    
    
    static func getDateDiff(start: Date, end: Date) -> Int  {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.minute], from: start, to: end)
        let minutes = dateComponents.minute
        return Int(minutes!)
    }
   
    static func daysBetween(start: Date, end: Date) -> Int {
        if let day = Calendar.current.dateComponents([.day], from: start, to: end).day{
            return day
        }
        return 0
    }
    
    static func minutesBetween(start: Date, end: Date) -> Int {
        if let minutes = Calendar.current.dateComponents([.minute], from: start, to: end).minute{
            return minutes
        }
        return 0
    }
    static func sunRiseInCorrectFormat(_ sunRiseSeconds: Double) -> String? {
        let time = Date(timeIntervalSince1970: sunRiseSeconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: time)
    }
    
    static func forcastDateInCorrectTime(_ forcastDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //"yyyy-MM-dd’T’hh:mm:ss.zzz"
        let date = dateFormatter.date(from: forcastDate)
        dateFormatter.dateFormat = "dd MMMM HH:mm"
        if date != nil{
            return  dateFormatter.string(from: date!)
        }else{
            return  ""
        }
    }
    
}
