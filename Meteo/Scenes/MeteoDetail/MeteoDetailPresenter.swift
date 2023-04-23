//
//  MeteoDetailPresenter.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import Foundation

protocol MeteoDetailPresentationLogic {
    func presentMeteoDetail(response: FetchWeather.Response)
}

class MeteoDetailPresenter: MeteoDetailPresentationLogic {
    
    private weak var viewController: MeteoDetailDisplayLogic?
    private let builder: MeteoDetailBuilderProtocol
    
    init(viewController: MeteoDetailDisplayLogic?, builder: MeteoDetailBuilderProtocol) {
        self.viewController = viewController
        self.builder = builder
    }
    
    func presentMeteoDetail(response: FetchWeather.Response) {
        let displayedWeather = builder.buildWeather(model: response.model)
        viewController?.displayMeteoDetail(viewModel: .init(displayedWeatherDetail: displayedWeather))
    }
}
