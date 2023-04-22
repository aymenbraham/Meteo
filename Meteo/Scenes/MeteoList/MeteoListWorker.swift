//
//  MeteoListWorker.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListWorkerProtocol {
    func fetchMeteoCity(q: String, completion: @escaping MeteoCityApiProtocol.MeteoCityCompletion)
    func fetchAllCity(completion: @escaping CityDataSourceProtocol.FetchLocalCityCompletion)
}

struct MeteoListWorker: MeteoListWorkerProtocol {

    private let cityApi: MeteoCityApiProtocol
    private var cityDataStore: CityDataSourceProtocol
    
    init(cityApi: MeteoCityApiProtocol, cityDataStore: CityDataSourceProtocol) {
        self.cityApi = cityApi
        self.cityDataStore = cityDataStore
    }
    
    func fetchMeteoCity(q: String, completion: @escaping MeteoCityApiProtocol.MeteoCityCompletion) {
        self.cityApi.fetchMeteoCity(q: q, completion: completion)
    }
    
    func fetchAllCity(completion: @escaping CityDataSourceProtocol.FetchLocalCityCompletion) {
        cityDataStore.fetchAllCity(completion: completion)
    }
}
