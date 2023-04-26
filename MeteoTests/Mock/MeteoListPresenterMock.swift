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
    
    func presentFetchMeteoList(response: FetchWeather.Response) {
        presentFetchMeteoListResponse = response
    }
}
