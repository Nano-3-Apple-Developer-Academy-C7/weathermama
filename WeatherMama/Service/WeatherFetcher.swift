//
//  WeatherFetcher.swift
//  WeatherMama
//
//  Created by Mika S Rahwono on 15/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

@available(iOS 17.0, *)
class WeatherFetcher {
    
    private let weatherService = WeatherService.shared
    
    func fetchHourlyWeather(for location: CLLocation, completion: @escaping (Result<[HourlyWeatherData], Error>) -> Void) {
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                let calendar = Calendar.current
                let currentDate = calendar.startOfDay(for: Date())
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                
                let hourlyWeatherData = weather.hourlyForecast.filter { forecast in
                    forecast.date >= currentDate && forecast.date < endOfDay
                }.map { forecast in
                    HourlyWeatherData(
                        date: forecast.date,
                        temperature: forecast.temperature.value,
                        humidity: forecast.humidity,
                        windSpeed: ceil(forecast.wind.speed.value),
                        precipitationChance: forecast.precipitationChance
                    )
                }
                
                completion(.success(hourlyWeatherData))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
