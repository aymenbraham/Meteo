//
//  WeatherDetailDB+CoreDataProperties.swift
//  Meteo
//
//  Created by aymen braham on 24/04/2023.
//

import CoreData
import Foundation

public extension WeatherDetailDB {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WeatherDetailDB> {
        return NSFetchRequest<WeatherDetailDB>(entityName: "WeatherDetail")
    }

    @nonobjc class func fetchRequest(cityName: String) -> NSFetchRequest<WeatherDetailDB> {
        let fetchRequest = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityName = %@", cityName)
        return fetchRequest
    }
    
    @NSManaged var cityName: String
    @NSManaged var current: WeatherDB
    @NSManaged var hourly: Set<WeatherDB>
    @NSManaged var daily: Set<WeatherDailyDB>
}

public extension WeatherDB {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WeatherDB> {
        return NSFetchRequest<WeatherDB>(entityName: "Weather")
    }

    @NSManaged var date: Int64
    @NSManaged var temperature: Double
    @NSManaged var weatherDescription: Set<WeatherDescriptionDB>
}

public extension WeatherDailyDB {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WeatherDailyDB> {
        return NSFetchRequest<WeatherDailyDB>(entityName: "WeatherDaily")
    }

    @NSManaged var date: Int64
    @NSManaged var tempMin: Double
    @NSManaged var tempMax: Double
    @NSManaged var dailyDescription: Set<WeatherDescriptionDB>
}

public extension WeatherDescriptionDB {
    @nonobjc class func fetchRequest() -> NSFetchRequest<WeatherDescriptionDB> {
        return NSFetchRequest<WeatherDescriptionDB>(entityName: "WeatherDescription")
    }

    @NSManaged var descriptionText: String
    @NSManaged var icon: String
    @NSManaged var main: String
}
