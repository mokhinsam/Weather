//
//  SectionHeader.swift
//  Weather
//
//  Created by Дарина Самохина on 25.03.2025.
//

struct SectionHeader {
    let image: Image
    let title: Title
    
    static func getHeaders() -> [SectionHeader] {
        [
            SectionHeader(image: .clock, title: .hourly),
            SectionHeader(image: .calendar, title: .daily)
        ]
    }
}

enum Image: String {
    case clock
    case calendar
}

enum Title: String {
    case hourly = "Hourly Forecast"
    case daily = "3-day Forecast"
}
