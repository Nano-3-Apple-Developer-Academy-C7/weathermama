//
//  WeatherViewController.swift
//  WeatherMama
//
//  Created by Mika S Rahwono on 15/07/24.
//

import UIKit
import CoreLocation

@available(iOS 17.0, *)
extension MainViewController {
        
    @IBAction func fetchWeatherData(_ sender: UIButton) {
        guard let location = locationManager.location else {
            topContainerView.setRecomendationLabel("Unable to fetch location")
            return
        }
        fetchWeather(for: location)
        
    }
    
    func fetchWeather(for location: CLLocation) {
        weatherFetcher.fetchHourlyWeather(for: location) { result in
            switch result {
            case .success(let hourlyWeatherData):
                let potentialWindow = self.recommendLaundryTimes(hourlyForecast: hourlyWeatherData)
                self.recommendationTimes = self.recommendLaundryTimes(hourlyForecast: hourlyWeatherData)
                print(potentialWindow[0])
                print(hourlyWeatherData)
                self.mainBoxContainerView.hourlyWeatherData = hourlyWeatherData
                DispatchQueue.main.async {
                    if potentialWindow[0].duration >= 10800 {
                        self.topContainerView.setRecomendationLabel("Perfect day to dry your clothes")
                        self.centerContainerView.setDescriptionLabel("Optimal Condition for Quick Drying")
                        
                        let calendar = Calendar.current

                        // Assuming startTime and endTime are of type Date and not optional
                        let startTime = potentialWindow[0].startTime
                        let endTime = potentialWindow[0].endTime

                        let midpointInterval = (startTime.timeIntervalSince1970 + endTime.timeIntervalSince1970) / 2
                        let midpointDate = Date(timeIntervalSince1970: midpointInterval)

                        let hourFormatter = DateFormatter()
                        hourFormatter.dateFormat = "HH:mm"
                        let midpointTimeString = hourFormatter.string(from: midpointDate)

                        self.centerContainerView.setBestTimeLabel(midpointTimeString)
                        
                    } else {
                        self.topContainerView.setRecomendationLabel("Not the best day to dry your clothes")
                        
                        if potentialWindow.count > 1 {
                            self.centerContainerView.setDescriptionLabel("THE SUN’S OUT AGAIN!")
                            
                            let calendar = Calendar.current
                            if let twoHoursEarlier = calendar.date(byAdding: .hour, value: -2, to: potentialWindow[0].endTime) {
                                
                                let startTime = potentialWindow[0].startTime
                                let endTime = potentialWindow[0].endTime

                                let midpointInterval = (startTime.timeIntervalSince1970 + endTime.timeIntervalSince1970) / 2
                                let midpointDate = Date(timeIntervalSince1970: midpointInterval)

                                let hourFormatter = DateFormatter()
                                hourFormatter.dateFormat = "HH:mm"
                                let midpointTimeString = hourFormatter.string(from: midpointDate)

                                self.centerContainerView.setBestTimeLabel(midpointTimeString)
                            } else {
                                print("Failed to subtract 2 hours.")
                            }
                            
                        } else {
                            self.centerContainerView.setDescriptionLabel("IT WILL RAIN ALL DAY...")
                        }
                    }
                    let calendar = Calendar.current
                    
                    let currentHour = calendar.component(.hour, from: Date())
                    
                    
                    if self.mainBoxContainerView.indexHour == -1 {
                        self.mainBoxContainerView.humidityView.setHumidityRateLabel("\(hourlyWeatherData[currentHour].humidity * 100) %")
                        self.mainBoxContainerView.windView.setWindRateLabel("\(hourlyWeatherData[currentHour].windSpeed) Km/H")
                        self.mainBoxContainerView.temperatureView.setTemperatureRateLabel("\(hourlyWeatherData[currentHour].temperature) °")
                        self.mainBoxContainerView.precipitationView.setPrecipitationRateLabel("\(hourlyWeatherData[currentHour].precipitationChance * 100) %")
                        self.mainBoxContainerView.precipitationView.setPrecipitationStatusLabel("\(hourlyWeatherData[currentHour].precipitationCategory())")
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.topContainerView.setRecomendationLabel("Unable to fetch location")
                }
            }
        }
    }

    private func recommendLaundryTimes(hourlyForecast: [HourlyWeatherData]) -> [PotentialWindow] {
        var recommendations: [PotentialWindow] = []
        
        var potentialWindow: (start: Date, end: Date)?
        
        for hourWeather in hourlyForecast {
            let precipitationProbability = hourWeather.precipitationChance
            let temperature = hourWeather.temperature
            let humidity = hourWeather.humidity
            let windSpeed = hourWeather.windSpeed
            
            if precipitationProbability < 0.3 && temperature > 26 && humidity < 70 && windSpeed > 5{
                if potentialWindow == nil {
                    potentialWindow = (start: hourWeather.date, end: hourWeather.date)
                } else {
                    potentialWindow?.end = hourWeather.date
                }
            } else if let window = potentialWindow {
                let duration = window.end.timeIntervalSince(window.start)
                if duration >= 1080 {
                    recommendations.append(PotentialWindow(startTime: window.start, endTime: window.end, duration: duration))
                }
                potentialWindow = nil
            }
        }
        
        if let window = potentialWindow {
            let duration = window.end.timeIntervalSince(window.start)
            recommendations.append(PotentialWindow(startTime: window.start, endTime: window.end, duration: duration))
        }
        
        return recommendations
    }

    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
             fetchWeather(for: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        topContainerView.setRecomendationLabel("Failed to get user location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Location permission not determined.")
        case .restricted:
            print("Location permission restricted.")
        case .denied:
            print("Location permission denied.")
        case .authorizedAlways:
            print("Location permission authorized always.")
        case .authorizedWhenInUse:
            print("Location permission authorized when in use.")
        @unknown default:
            fatalError()
        }
    }
}
