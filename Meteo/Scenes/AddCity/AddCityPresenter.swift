//
//  AddCityPresenter.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

protocol CityListPresentationLogic {
    func presentFetchCityList(response: FetchCityList.Response)
}

class AddCityPresenter: CityListPresentationLogic {
    
    private weak var viewController: AddCitytDisplayLogic?
    private let builder: CityListBuilderProtocol
    
    init(viewController: AddCitytDisplayLogic?, builder: CityListBuilderProtocol) {
        self.viewController = viewController
        self.builder = builder
    }
    
    func presentFetchCityList(response: FetchCityList.Response) {
        let displayedCityList = builder.buildCityList(model: response.model)
        viewController?.displayCityList(viewModel: .init(displayedCityList: displayedCityList))
    }
    
}
