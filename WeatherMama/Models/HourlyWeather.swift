//
//  HourlyWeather.swift
//  WeatherMama
//
//  Created by Mika S Rahwono on 15/07/24.
//

import Foundation

struct HourlyWeatherData {
    let date: Date
    let temperature: Double
    let humidity: Double
    let windSpeed: Double
    let precipitationChance: Double
    
    func precipitationCategory() -> String {
        switch precipitationChance {
        case let x where x > 80:
            return "High Chance"
        case 50...80:
            return "Likely"
        case 20..<50:
            return "Possible"
        default:
            return "Unlikely"
        }
    }
    
    func windCategory() -> String {
        switch windSpeed {
        case let x where x > 8:
            return "Strong Breeze"
        case 5..<8:
            return "Moderate Breeze"
        case 1..<5:
            return "Light Breeze"
        default:
            return "Calm"
        }
    }
    
    func humidityCategory() -> String {
        switch humidity {
        case let x where x > 70:
            return "High Humidity"
        case 30..<70:
            return "Moderate Humidity"
        default:
            return "Low Humidity"
        }
    }
    
    func temperatureCategory() -> String {
        switch temperature {
        case let x where x > 30:
            return "Hot"
        case 20..<30:
            return "Warm"
        case 10..<20:
            return "Cool"
        default:
            return "Cold"
        }
    }
}
