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
    private var cityMeteoList: [MeteoCityResponse] = []
    private var cityNames: [String] = []
    
    init(worker: MeteoListWorkerProtocol, prenseter: MeteoListPresentationLogic) {
        self.worker = worker
        self.prenseter = prenseter
    }
    
    private func fetchCities() {
        worker.fetchAllCity() { result in
            switch result {
            case .success(let city):
                city.forEach { city in
                    self.cityNames.append("\(city.name),\(city.countryCode)")
                }
                print(city.count)
                print(self.cityNames.count)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.cityNames.forEach { name in
                        self.fetchMeteoCity(cityName: name)
                    }
                }
            case .failure(let error):
                print("Error here: \(error)")
            }
        }
    }
    
    private func fetchMeteoCity(cityName: String) {
        self.worker.fetchMeteoCity(q: cityName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cityMeteo):
                self.cityMeteoList.append(cityMeteo)
                self.prenseter.presentFetchMeteoList(response: FetchMeteoCityList.Response.init(model: self.cityMeteoList))
            case .failure(let error):
                print("Error here: \(error)")
            }
        }
    }
}

extension MeteoListInteractor: MeteoListBusinessLogic {
    func getCitiesList() {
        fetchCities()
    }
}
