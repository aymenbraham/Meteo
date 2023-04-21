//
//  MeteoListWorker.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListWorkerProtocol {
    func fetchMeteoCity(q: String, completion: @escaping MeteoCityApiProtocol.MeteoCityCompletion)
}

struct MeteoListWorker: MeteoListWorkerProtocol {

    private let cityApi: MeteoCityApiProtocol
    
    init(cityApi: MeteoCityApiProtocol) {
        self.cityApi = cityApi
    }
    
    func fetchMeteoCity(q: String, completion: @escaping MeteoCityApiProtocol.MeteoCityCompletion) {
        self.cityApi.fetchMeteoCity(q: q, completion: completion)
    }
}
