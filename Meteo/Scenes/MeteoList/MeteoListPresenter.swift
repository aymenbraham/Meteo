//
//  MeteoListPresenter.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListPresentationLogic {
    func presentFetchMeteoList(response: FetchMeteoCityList.Response)
}

class MeteoListPresenter: MeteoListPresentationLogic {
    
    private weak var viewController: MeteoListDisplayLogic?
    private let builder: MeteoListBuilderProtocol
    
    init(viewController: MeteoListDisplayLogic?, builder: MeteoListBuilderProtocol) {
        self.viewController = viewController
        self.builder = builder
    }
    
    func presentFetchMeteoList(response: FetchMeteoCityList.Response) {
        let displayedMeteoCityList = builder.buildMeteoCityList(model: response.model)
        viewController?.displayMeteoCityList(viewModel: .init(displayedMeteoCityList: displayedMeteoCityList))
    }
}
