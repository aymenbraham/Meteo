//
//  MeteoDetailPresenterMock.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

import Foundation
@testable import Meteo

class MeteoDetailPresenterMock: MeteoDetailPresentationLogic {

    var presentMeteoDetailResponse: FetchWeather.ResponseDetail?
    
    func presentMeteoDetail(response: FetchWeather.ResponseDetail) {
        presentMeteoDetailResponse = response
    }
}
