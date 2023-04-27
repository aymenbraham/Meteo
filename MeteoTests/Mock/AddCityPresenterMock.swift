//
//  AddCityPresenterMock.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

import Foundation
@testable import Meteo

class AddCityPresenterMock: CityListPresentationLogic {
    
    var presentFetchCityListResponse: FetchCityList.Response?
    var presentFetchCityError: ModelError?
    var shouldPresntError: Bool?
    
    func presentFetchCityList(response: FetchCityList.Response) {
        presentFetchCityListResponse = response
    }
    
    func presentError(error: ModelError) {
        presentFetchCityError = error
        shouldPresntError = true
    }
}
