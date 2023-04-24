//
//  MeteoListWorker.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation
import MapKit

protocol MeteoListWorkerProtocol: CityDataSourceProtocol {
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping WeatherAPIProtocol.WeatherCompletion)
}

struct MeteoListWorker {

    private let weatherApi: WeatherAPIProtocol
    private var cityDataStore: CityDataSourceProtocol
    
    init(weatherApi: WeatherAPIProtocol, cityDataStore: CityDataSourceProtocol) {
        self.weatherApi = weatherApi
        self.cityDataStore = cityDataStore
    }
}

// - Network
extension MeteoListWorker: MeteoListWorkerProtocol {
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping WeatherAPIProtocol.WeatherCompletion) {
        self.weatherApi.fetchWeather(lat: lat, lon: lon, completion: completion)
    }
}

// - Local
extension MeteoListWorker: CityDataSourceProtocol {
    func addCity(model: CityProtocol) -> CoreStackSaveResult {
        cityDataStore.addCity(model: model)
    }
    
    func fetchAllCity(completion: @escaping CityDataSourceProtocol.FetchLocalCityCompletion) {
        cityDataStore.fetchAllCity(completion: completion)
    }
    
    func getCityWithCountryCode(cityCode: String) -> CityDB? {
        cityDataStore.getCityWithCountryCode(cityCode: cityCode)
    }
}
