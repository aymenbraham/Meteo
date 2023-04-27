//
//  MeteoListPresenterMock.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

import Foundation
@testable import Meteo

class MeteoListPresenterMock: MeteoListPresentationLogic {
    
    var presentFetchMeteoListResponse: FetchWeather.Response?
    var presentFetchCityError: ModelError?
    var shouldPresntError: Bool?
    
    func presentFetchMeteoList(response: FetchWeather.Response) {
        presentFetchMeteoListResponse = response
    }
    
    func presentError(error: ModelError) {
        presentFetchCityError = error
        shouldPresntError = true
    }
}
