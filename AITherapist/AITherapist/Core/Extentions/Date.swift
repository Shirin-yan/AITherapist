//
//  Date.swift
//  AITherapist
//
//  Created by Shirin-Yan on 12.09.2024.
//

import Foundation

extension Date {
    func get12hourFuture() -> String {
        let currentDate = Date()
        let futureDate = currentDate.addingTimeInterval(12 * 60 * 60)
//        let isoDateFormatter =
//        isoDateFormatter.formatOptions = [.withInternetDateTime]
        print(ISO8601DateFormatter().string(from: futureDate))
        print(Date().ISO8601Format())
        return ISO8601DateFormatter().string(from: futureDate)
    }
}

extension String {
    func getDate() -> Date {
        let isoDateFormatter = ISO8601DateFormatter()
        return isoDateFormatter.date(from: self) ?? Date()
    }
    
    func fullTwelveHourIntervals() -> Int {
        let endDate = self.getDate()
        if endDate > Date() { return 0 }

        let timeInterval = Date().timeIntervalSince(endDate)
        let twelveHoursInSeconds: TimeInterval = 12 * 60 * 60
        return Int(timeInterval / twelveHoursInSeconds)
    }
    
    func addTwelveHours(_ data: Int) -> String {
        let date = self.getDate().addingTimeInterval(TimeInterval(data*(12 * 60 * 60)))
        return date.ISO8601Format()
    }
}
