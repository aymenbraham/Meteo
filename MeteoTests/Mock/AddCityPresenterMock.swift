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
    
    func presentFetchCityList(response: FetchCityList.Response) {
        presentFetchCityListResponse = response
    }
}
