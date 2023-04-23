//
//  MeteoListRouter.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListRouting {
    func goToAddCity()
    func goToMeteoDetail(model: WeatherProtocol)
}

class MeteoListRouter: MeteoListRouting {
    
    private weak var viewController: MeteoListViewController?
    
    init(viewController: MeteoListViewController) {
        self.viewController = viewController
    }
    
    func goToAddCity() {
        viewController?.navigationController?.present(CityListScene.initialization.configure(), animated: true)
    }
    
    func goToMeteoDetail(model: WeatherProtocol) {
        viewController?.navigationController?.pushViewController(MeteoDetailScene.initialization(model).configure(), animated: true)
    }
}
