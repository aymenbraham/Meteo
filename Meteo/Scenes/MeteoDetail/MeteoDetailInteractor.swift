//
//  MeteoDetailInteractor.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import Foundation

protocol MeteoDetailBusinessLogic {
    func getWeather()
    var weather: WeatherProtocol { get }
}

class MeteoDetailInteractor {
    
    private let prenseter: MeteoDetailPresentationLogic
    var weather: WeatherProtocol
    
    init(prenseter: MeteoDetailPresentationLogic,
         weather: WeatherProtocol) {
        self.prenseter = prenseter
        self.weather = weather
    }
}

extension MeteoDetailInteractor: MeteoDetailBusinessLogic {
    func getWeather() {
        prenseter.presentMeteoDetail(response: FetchWeather.Response.init(model: weather))
    }
    
//    worker.fetchMeteoCity(lat: 33.44, lon: -94.04) { [weak self] result in
//        guard let self = self else { return }
//        switch result {
//        case .success(let weather):
//            print(weather)
//            self.prenseter.presentMeteoDetail(response: FetchWeather.Response.init(model: weather))
//        case .failure(let error):
//            print(error)
//        }
//    }
}
