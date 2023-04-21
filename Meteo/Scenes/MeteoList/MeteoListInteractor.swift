//
//  MeteoListInteractor.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListBusinessLogic {
    func getCityList()
}

class MeteoListInteractor {
    
    private let worker: MeteoListWorkerProtocol
    private let prenseter: MeteoListPresentationLogic
    private var cityMeteoList: [MeteoCityResponse] = []
    
    init(worker: MeteoListWorkerProtocol, prenseter: MeteoListPresentationLogic) {
        self.worker = worker
        self.prenseter = prenseter
    }
    
}

extension MeteoListInteractor: MeteoListBusinessLogic {
    func getCityList() {
        self.worker.fetchMeteoCity(q: "Paris,fr") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cityMeteo):
                print("cityMeto : \(cityMeteo)")
                self.cityMeteoList.append(cityMeteo)
                self.prenseter.presentFetchMeteoList(response: FetchMeteoCityList.Response.init(model: self.cityMeteoList))
            case .failure(let error):
                print("Error here: \(error)")
                
            }
        }
    }
}
