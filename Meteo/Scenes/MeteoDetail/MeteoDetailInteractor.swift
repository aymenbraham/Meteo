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
        prenseter.presentMeteoDetail(response: FetchWeather.ResponseDetail.init(model: weather))
    }
}
