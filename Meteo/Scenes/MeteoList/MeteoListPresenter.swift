//
//  MeteoListPresenter.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListPresentationLogic {
    func presentFetchMeteoList(response: FetchWeather.Response)
    func presentError(error: ModelError)
}

class MeteoListPresenter: MeteoListPresentationLogic {
    
    private weak var viewController: MeteoListDisplayLogic?
    private let builder: MeteoListBuilderProtocol
    
    init(viewController: MeteoListDisplayLogic?, builder: MeteoListBuilderProtocol) {
        self.viewController = viewController
        self.builder = builder
    }
    
    func presentFetchMeteoList(response: FetchWeather.Response) {
        let displayedMeteoCityList = builder.buildMeteoCityList(model: response.model)
        viewController?.displayMeteoCityList(viewModel: .init(displayedMeteoCityList: displayedMeteoCityList))
    }
    
    func presentError(error: ModelError) {
        viewController?.displayError(error: error)
    }
}
