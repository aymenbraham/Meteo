//
//  MeteoListWorker.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation
import MapKit

protocol MeteoListWorkerProtocol: CityDataSourceProtocol, WeatherDataStoreProtocol {
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping WeatherAPIProtocol.WeatherCompletion)
}

struct MeteoListWorker {

    private let weatherApi: WeatherAPIProtocol
    private var cityDataStore: CityDataSourceProtocol
    private let weatherDataStore: WeatherDataStoreProtocol
    
    init(weatherApi: WeatherAPIProtocol, cityDataStore: CityDataSourceProtocol, weatherDataStore: WeatherDataStoreProtocol) {
        self.weatherApi = weatherApi
        self.cityDataStore = cityDataStore
        self.weatherDataStore = weatherDataStore
    }
}

// - Network
extension MeteoListWorker: MeteoListWorkerProtocol {
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping WeatherAPIProtocol.WeatherCompletion) {
        self.weatherApi.fetchWeather(lat: lat, lon: lon, completion: completion)
    }
}

// - Local CityDataSourceProtocol
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

extension MeteoListWorker: WeatherDataStoreProtocol {
    func addWeather(model: WeatherProtocol) -> CoreStackSaveResult? {
        weatherDataStore.addWeather(model: model)
    }
    
    func fetchWeather(completion: @escaping FetchLocalWeatherCompletion) {
        weatherDataStore.fetchWeather(completion: completion)
    }
    
    func getWeatherWithCityName(cityName: String) -> WeatherDetailDB? {
        weatherDataStore.getWeatherWithCityName(cityName: cityName)
    }
}
