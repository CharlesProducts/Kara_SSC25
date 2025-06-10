//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//
import SwiftUI

public extension Date {
    
    var startOfWeek: Date? {
        
        /// Gets the start of the week
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        let resultDate = calendar.date(byAdding: .day, value: 0, to: calendar.date(from: components) ?? Date())
        return resultDate
    }
    
    var endOfWeek: Date? {
        
        /// Gets the end of the week
        
        let calendar = Calendar.current
        guard let startOfWeek = self.startOfWeek else { return nil }
        return calendar.date(byAdding: .day, value: 7, to: startOfWeek)
    }
    
    
    static func isInCurrentWeek(offset: Int = 0, date: Date) -> Bool {
        
        /// Checks if a date is in the current week
        
        let calendar = Calendar.current
        let currentDate = Date()
        guard let startOfWeek = currentDate.startOfWeek,
              let endOfWeek = currentDate.endOfWeek else { return false }
        
        if offset == 0 {
            let range = startOfWeek...endOfWeek
            return range.contains(date)
        } else {
            guard let startOfWeekWithOffset = calendar.date(byAdding: .day, value: 7 * offset, to: startOfWeek),
                  let endOfWeekWithOffset = calendar.date(byAdding: .day, value: 7 * offset, to: endOfWeek) else { return false }
            let rangeWithOffset = startOfWeekWithOffset...endOfWeekWithOffset
            return rangeWithOffset.contains(date)
        }
    }
    
    static func initDateAt(day: Int, month: Int, year: Int, hour: Int, minutes: Int) -> Date {
        
        /// Initializes at a certain date
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minutes
        
        if let specificDate = Calendar.current.date(from: components) {
            return specificDate
        } else {
            return Date()
        }
    }
}
