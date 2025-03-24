//
//  Weather.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

struct Weather: Decodable {
    let current: Current
    let forecast: Forecast
    let location: Location
}

struct Current: Decodable {
    let tempC: Double
    let condition: Condition
    let feelsLikeC: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition = "condition"
        case feelsLikeC = "feelslike_c"
    }
}

struct Forecast: Decodable {
    let forecastDay: [ForecastDay]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct Location: Decodable {
    let name: String
    let country: String
    let localTime: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case country = "country"
        case localTime = "localtime"
    }
}

struct ForecastDay: Decodable {
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: Decodable {
    let maxTempC: Double
    let minTempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case minTempC = "mintemp_c"
        case condition = "condition"
    }
}

struct Hour: Decodable {
    let time: String
    let tempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case tempC = "temp_c"
        case condition = "condition"
    }
}

struct Condition: Decodable {
    let text: String
    let icon: String
}
