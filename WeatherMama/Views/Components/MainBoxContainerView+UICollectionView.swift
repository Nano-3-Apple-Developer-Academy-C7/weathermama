//
//  MainBoxContainerView+UICollectionView.swift
//  WeatherMama
//
//  Created by Lucky on 18/07/24.
//

import UIKit

extension MainBoxContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCollectionViewCell", for: indexPath) as! ClockCollectionViewCell
        
        let hour = indexPath.item
        
        cell.clockView?.setHour(hour + 1)
        
        if hour == sunriseHour - 1 {
            cell.clockView?.setSymbol("sunrise")
        } else if hour == sunsetHour - 1 {
            cell.clockView?.setSymbol("sunset")
        } else if hour < 5 || hour > 17 {
            cell.clockView?.setSymbol("moon.zzz")
        } else {
            cell.clockView?.setSymbol("sun.max")
        }

        if hour + 1 >= startHour && hour + 1 <= endHour {
            cell.clockView?.setHourColor(.label)
            cell.clockView?.setSymbolColor(.orange)
            cell.isUserInteractionEnabled = true
        } else if hour < self.currentHour - 1 {
            cell.clockView?.setHourColor(.gray)
            cell.clockView?.setSymbolColor(.gray)
            cell.isUserInteractionEnabled = false
        } else {
            cell.clockView?.setHourColor(.label)
            cell.clockView?.setSymbolColor(.label)
            cell.isUserInteractionEnabled = true
        }

        
        return cell
    }
}

extension MainBoxContainerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        if indexPath.item < self.currentHour - 1 {
            return
        }
        
        indexHour = indexPath.item
        
        DispatchQueue.main.async {
            self.humidityView.setHumidityRateLabel(String(format: "%.0f %%", self.hourlyWeatherData[indexPath.item].humidity * 100))
            self.windView.setWindRateLabel(String(format: "%.0f Km/H", self.hourlyWeatherData[indexPath.item].windSpeed))
            self.temperatureView.setTemperatureRateLabel(String(format: "%.0f °", self.hourlyWeatherData[indexPath.item].temperature))
            self.precipitationView.setPrecipitationRateLabel(String(format: "%.0f %%", self.hourlyWeatherData[indexPath.item].precipitationChance * 100))
            self.precipitationView.setPrecipitationStatusLabel("\(self.hourlyWeatherData[indexPath.item].precipitationCategory())")
        }
        
        // Update the appearance of the selected cell
        if let cell = collectionView.cellForItem(at: indexPath) as? ClockCollectionViewCell {
            cell.isSelected = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ClockCollectionViewCell {
            cell.isSelected = false
        }
    }
}
