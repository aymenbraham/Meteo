//
//  MeteoListInteractor.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListBusinessLogic {
    func getCitiesList()
}

class MeteoListInteractor {
    
    private let worker: MeteoListWorkerProtocol
    private let prenseter: MeteoListPresentationLogic
    private var cityMeteoList: [WeatherProtocol] = []
    private var coordinate: [Coordinate] = []
    
    init(worker: MeteoListWorkerProtocol, prenseter: MeteoListPresentationLogic) {
        self.worker = worker
        self.prenseter = prenseter
    }
    
    private func fetchCities() {
        worker.fetchAllCity() { result in
            switch result {
            case .success(let city):
                city.forEach { city in
                    self.coordinate.append(Coordinate(lat: city.lat, lon: city.lng, cityName: city.name))
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.coordinate.forEach { coordinate in
                        self.fetchMeteoCity(lat: coordinate.lat, lon: coordinate.lon, cityName: coordinate.cityName)
                    }
                }
            case .failure(let error):
                print("Error here: \(error)")
            }
        }
    }
    
    private func fetchMeteoCity(lat: Double, lon: Double, cityName: String) {
        worker.fetchWeatherCity(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                var weather = weather
                weather.cityName = cityName
                self.cityMeteoList.append(weather)
                self.prenseter.presentFetchMeteoList(response: FetchWeather.Responseee.init(model: self.cityMeteoList))
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MeteoListInteractor: MeteoListBusinessLogic {
    func getCitiesList() {
        fetchCities()
    }
}
