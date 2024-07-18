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
    
    func fetchSunriseAndSunset(for location: CLLocation, completion: @escaping (Result<SunEventModel, Error>) -> Void) {
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                
                let calendar = Calendar.current
                let currentDate = calendar.startOfDay(for: Date())
                
                guard let todayWeather = weather.dailyForecast.first(where: { calendar.isDate($0.date, inSameDayAs: currentDate) }) else {
                    throw WeatherFetchError.noDataAvailable
                }
                
                guard let sunrise = todayWeather.sun.sunrise,
                      let sunset = todayWeather.sun.sunset else {
                    throw WeatherFetchError.missingData
                }
                
                let sunEvent = SunEventModel(sunrise: sunrise, sunset: sunset)
                completion(.success(sunEvent))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    enum WeatherFetchError: Error {
        case noDataAvailable
        case missingData
    }

}
