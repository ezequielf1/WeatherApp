//
//  DateMapper.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation

struct DateMapper {
    static func format(dateString: String) -> DateInformation? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.string(from: date)

        let calendar = Calendar.current
        let time = calendar.dateComponents([.hour,.minute, .day], from: date)
        let timeText = ("\(String(format: "%02d", time.hour!)):\(String(format: "%02d", time.minute!))")
        return .init(dayText: day, time: timeText, dayNumber: time.day!)
    }
}
