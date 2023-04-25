//
//  AddCityWorker.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

protocol CityListWorkerProtocol: CityDataSourceProtocol {
    func fetchCity(completion: @escaping CityListApiProtocol.CityCompletion)
}

struct AddCityWorker {

    private let cityListApi: CityListApiProtocol
    private var cityDataStore: CityDataSourceProtocol
    
    init(cityListApi: CityListApiProtocol, cityDataStore: CityDataSourceProtocol) {
        self.cityListApi = cityListApi
        self.cityDataStore = cityDataStore
    }
}

// - Network
extension AddCityWorker: CityListWorkerProtocol {
    func fetchCity(completion: @escaping CityListApiProtocol.CityCompletion) {
        self.cityListApi.fetchMeteoCity(completion: completion)
    }
}

// - Local
extension AddCityWorker: CityDataSourceProtocol {
    func addCity(model: CityProtocol) -> CoreStackSaveResult {
        cityDataStore.addCity(model: model)
    }
    
    func fetchAllCity(completion: @escaping FetchLocalCityCompletion) {
        cityDataStore.fetchAllCity(completion: completion)
    }
    
    func getCityWithCountryCode(cityCode: String) -> CityDB? {
        cityDataStore.getCityWithCountryCode(cityCode: cityCode)
    }
}
