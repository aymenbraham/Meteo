//
//  AddCityWorker.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

protocol CityListWorkerProtocol {
    func fetchCity(name: String, completion: @escaping CityListApiProtocol.CityCompletion)
}

struct AddCityWorker: CityListWorkerProtocol {

    private let cityListApi: CityListApiProtocol
    
    init(cityListApi: CityListApiProtocol) {
        self.cityListApi = cityListApi
    }
    
    func fetchCity(name: String, completion: @escaping CityListApiProtocol.CityCompletion) {
        self.cityListApi.fetchMeteoCity(name: name, completion: completion)
    }
}
