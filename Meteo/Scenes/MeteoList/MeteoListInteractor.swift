//
//  MeteoListInteractor.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation
import CoreLocation

protocol MeteoListBusinessLogic {
    func getCitiesList()
}

class MeteoListInteractor {
    
    private let worker: MeteoListWorkerProtocol
    private let prenseter: MeteoListPresentationLogic
    private var cityMeteoList: [WeatherProtocol] = []
    private var coordinate: [Coordinate] = []
    private let locationManager = LocationManager()
    
    init(worker: MeteoListWorkerProtocol, prenseter: MeteoListPresentationLogic) {
        self.worker = worker
        self.prenseter = prenseter
    }
        
    private func fetchCities() {
        cityMeteoList = []
        coordinate = []
        worker.fetchAllCity() { result in
            switch result {
            case .success(let city):
                if city.isEmpty {
                    self.getLocationMeteo()
                    return
                }
                city.forEach { city in
                    self.coordinate.append(Coordinate(lat: city.lat, lon: city.lng, cityName: city.name))
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.coordinate.forEach { coordinate in
                        if NetworkReachability.isConnectedToNetwork() {
                            self.fetchMeteoCity(lat: coordinate.lat, lon: coordinate.lon, cityName: coordinate.cityName)
                        } else {
                            guard let weatherDB = self.worker.getWeatherWithCityName(cityName: coordinate.cityName) else { return }
                            let weather = weatherDB.convertWeatherDBToWeather(model: weatherDB)
                            self.cityMeteoList.append(weather)
                            self.prenseter.presentFetchMeteoList(response: FetchWeather.Response.init(model: self.cityMeteoList))
                        }
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
                let _ = self.worker.addWeather(model: weather)
                self.prenseter.presentFetchMeteoList(response: FetchWeather.Response.init(model: self.cityMeteoList))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getLocationMeteo() {
        locationManager.requestLocation { location in
            guard let location = location else { return }
            let lat = location.coordinate.latitude
            let lng = location.coordinate.latitude
            let city = City(name: "My postion", cityCode: "My postion", lat: lat, lng: lng, countryCode: "My postion")
            self.cityMeteoList = []
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let _ = self.worker.addCity(model: city)
                self.fetchMeteoCity(lat: lat, lon: lng, cityName: city.name)
            }
        }
    }
}

extension MeteoListInteractor: MeteoListBusinessLogic {
    func getCitiesList() {
        fetchCities()
    }
}
