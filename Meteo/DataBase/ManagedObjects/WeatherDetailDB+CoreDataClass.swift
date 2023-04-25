//
//  WeatherDetailDB+CoreDataClass.swift
//  Meteo
//
//  Created by aymen braham on 24/04/2023.
//

import CoreData
import Foundation

@objc(WeatherDetailDB)
public class WeatherDetailDB: NSManagedObject {
    
    func populate(model: WeatherProtocol) {
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        current = convertWeatherToWeatherDB(model: model.current)
        let hourlyDB: [WeatherDB] = model.hourly.compactMap {
            var hourlyDB = WeatherDB(context: managedObjectContext)
            hourlyDB = convertWeatherToWeatherDB(model: $0)
            return hourlyDB
        }
        hourly = Set(hourlyDB)
        let dailyDB: [WeatherDailyDB] = model.daily.compactMap {
            let dailyDB = WeatherDailyDB(context: managedObjectContext)
            dailyDB.date = Int64($0.date)
            dailyDB.tempMin = $0.temperature.min
            dailyDB.tempMax = $0.temperature.max
            let dailyDescription: [WeatherDescriptionDB] = $0.weather.compactMap { weatherDescription in
                let dailyDescription = WeatherDescriptionDB(context: managedObjectContext)
                dailyDescription.descriptionText = weatherDescription.description
                dailyDescription.icon = weatherDescription.icon
                dailyDescription.main = weatherDescription.main
                return dailyDescription
            }
            dailyDB.dailyDescription = Set(dailyDescription)
            return dailyDB
        }
        daily = Set(dailyDB)
        cityName = model.cityName ?? ""
    }
    
    func convertWeatherDBToWeather(model: WeatherDetailDB) -> WeatherProtocol {
        let current = convertWeather(model: model.current)
        var hourly: [Weather] = []
       let _ = model.hourly.compactMap {
            hourly.append(convertWeather(model: $0))
        }
        hourly.sort { $0.date < $1.date }
        var daily: [WeatherDaily] = []
        let _ = model.daily.compactMap {
            daily.append(convertToWeatherDaily(model: $0))
        }
        daily.sort { $0.date < $1.date }
        return WeatherResponse(current: current,
                               hourly: hourly,
                               daily: daily,
                               cityName: model.cityName)
    }
    
    private  func convertWeatherToWeatherDB(model: Weather) -> WeatherDB {
        let weatherDB = WeatherDB(context: managedObjectContext!)
        weatherDB.temperature = model.temperature
        weatherDB.date = Int64(model.date)
        let weatherDescription: [WeatherDescriptionDB] = model.weather.compactMap {
            let weatherDescription = WeatherDescriptionDB(context: managedObjectContext!)
            weatherDescription.main = $0.main
            weatherDescription.descriptionText = $0.description
            weatherDescription.icon = $0.icon
            return weatherDescription
        }
        weatherDB.weatherDescription = Set(weatherDescription)
        return weatherDB
    }
    
    private func convertWeather(model: WeatherDB) -> Weather {
        var weather = Weather()
        weather.date = Int(model.date)
        weather.temperature = model.temperature
        let _ = model.weatherDescription.compactMap {
            weather.weather.append(WeatherDetail(main: $0.main, description: $0.descriptionText, icon: $0.icon))
        }
        return weather
    }
    
    private func convertToWeatherDaily(model: WeatherDailyDB) -> WeatherDaily {
        var weatherDaily =  WeatherDaily()
        weatherDaily.date = Int(model.date)
        weatherDaily.temperature = Temperature(min: model.tempMin, max: model.tempMax)
        let _ = model.dailyDescription.compactMap {
            weatherDaily.weather.append(WeatherDetail(main: $0.main, description: $0.descriptionText, icon: $0.icon))
        }
        return weatherDaily
    }
    
}

@objc(WeatherDB)
public class WeatherDB: NSManagedObject {}

@objc(WeatherDailyDB)
public class WeatherDailyDB: NSManagedObject {}

@objc(WeatherDescriptionDB)
public class WeatherDescriptionDB: NSManagedObject {}


