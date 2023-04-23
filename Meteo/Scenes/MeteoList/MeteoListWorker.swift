//
//  MeteoListWorker.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListWorkerProtocol {
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping WeatherAPIProtocol.WeatherCompletion)
    func fetchAllCity(completion: @escaping CityDataSourceProtocol.FetchLocalCityCompletion)
}

struct MeteoListWorker: MeteoListWorkerProtocol {

    private let weatherApi: WeatherAPIProtocol
    private var cityDataStore: CityDataSourceProtocol
    
    init(weatherApi: WeatherAPIProtocol, cityDataStore: CityDataSourceProtocol) {
        self.weatherApi = weatherApi
        self.cityDataStore = cityDataStore
    }
    
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping WeatherAPIProtocol.WeatherCompletion) {
        self.weatherApi.fetchWeather(lat: lat, lon: lon, completion: completion)
    }
    
    func fetchAllCity(completion: @escaping CityDataSourceProtocol.FetchLocalCityCompletion) {
        cityDataStore.fetchAllCity(completion: completion)
    }
}
