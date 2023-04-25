//
//  WeatherDataSource.swift
//  Meteo
//
//  Created by aymen braham on 24/04/2023.
//

import Foundation
import CoreData

protocol WeatherDataStoreProtocol {
    typealias FetchLocalWeatherCompletion = (Result<[WeatherDetailDB], Error>) -> Void
    func addWeather(model: WeatherProtocol) -> CoreStackSaveResult?
    func fetchWeather(completion: @escaping FetchLocalWeatherCompletion)
    func getWeatherWithCityName(cityName: String) -> WeatherDetailDB?
}

struct WeatherDataStore: WeatherDataStoreProtocol {

    private let dataStack: CoreDataStackProtocol
    
    init(dataStack: CoreDataStackProtocol) {
        self.dataStack = dataStack
    }
    
    func addWeather(model: WeatherProtocol) -> CoreStackSaveResult? {
        guard let cityName = model.cityName else { return nil }
        guard let weather = getWeatherWithCityName(cityName: cityName) else {
            let weather = WeatherDetailDB(context: dataStack.managedContext)
            weather.populate(model: model)
            return dataStack.saveContext()
        }
        dataStack.managedContext.delete(weather)
        let _ = dataStack.saveContext()
        let newWeather = WeatherDetailDB(context: dataStack.managedContext)
        newWeather.populate(model: model)
        return dataStack.saveContext()
    }
    
    func fetchWeather(completion: @escaping FetchLocalWeatherCompletion) {
        let weatherFetchRequest: NSFetchRequest<WeatherDetailDB> = WeatherDetailDB.fetchRequest()
        let asyncFetchRequest = NSAsynchronousFetchRequest<WeatherDetailDB>(fetchRequest: weatherFetchRequest) { result in
            guard let weathers = result.finalResult else {
                completion(.success([]))
                return
            }
            completion(.success(weathers))
        }
        do {
            try dataStack.managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func getWeatherWithCityName(cityName: String) -> WeatherDetailDB? {
        if let fetchResult = try? dataStack.managedContext.fetch(WeatherDetailDB.fetchRequest(cityName: cityName)) {
            return fetchResult.first
        } else {
            return nil
        }
    }
    
}
