//
//  WeatherViewController.swift
//  WeatherMama
//
//  Created by Mika S Rahwono on 15/07/24.
//

import UIKit
import CoreLocation

@available(iOS 17.0, *)
class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var weatherLabel: UILabel!
    
    private let weatherFetcher = WeatherFetcher()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func fetchWeatherData(_ sender: UIButton) {
        guard let location = locationManager.location else {
            weatherLabel.text = "Unable to fetch location."
            return
        }
        fetchWeather(for: location)
    }
    
    private func fetchWeather(for location: CLLocation) {
        weatherFetcher.fetchHourlyWeather(for: location) { result in
            switch result {
            case .success(let hourlyWeatherData):
                DispatchQueue.main.async {
                    self.weatherLabel.text = self.formatWeatherData(hourlyWeatherData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.weatherLabel.text = "Error fetching weather data: \(error)"
                }
            }
        }
    }
    
    private func formatWeatherData(_ data: [HourlyWeatherData]) -> String {
        var result = ""
        for item in data.prefix(24) { // Limiting to 24 hours
            result += "Date: \(item.date)\n"
            result += "Temp: \(item.temperature)°C (\(item.temperatureCategory()))\n"
            result += "Humidity: \(item.humidity)% (\(item.humidityCategory()))\n"
            result += "Wind: \(item.windSpeed)m/s (\(item.windCategory()))\n"
            result += "Precipitation: \(item.precipitationChance)% (\(item.precipitationCategory()))\n\n"
        }
        return result
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
             fetchWeather(for: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        weatherLabel.text = "Failed to get user location: \(error.localizedDescription)"
    }
}
