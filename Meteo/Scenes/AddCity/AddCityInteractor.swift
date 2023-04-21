//
//  AddCityInteractor.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

protocol CityListBusinessLogic {
    func getCityList()
}

class AddCityInteractor {
    
    private let worker: CityListWorkerProtocol
    private let prenseter: CityListPresentationLogic
    
    init(worker: CityListWorkerProtocol, prenseter: CityListPresentationLogic) {
        self.worker = worker
        self.prenseter = prenseter
    }
}

extension AddCityInteractor: CityListBusinessLogic {
    func getCityList() {
        self.worker.fetchCity(name: "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cityList):
                self.prenseter.presentFetchCityList(response: FetchCityList.Response.init(model: cityList.response))
            case .failure(let error):
                print("Error here: \(error)")
                
            }
        }
    }
}
