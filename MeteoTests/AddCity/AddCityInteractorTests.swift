//
//  AddCityInteractorTests.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

@testable import Meteo
import Foundation
import XCTest

class AddCityInteractorTests: XCTestCase {
    
    var interactor: AddCityInteractor!
    var mockPresenter: AddCityPresenterMock!
    var mockWorker: AddCityWorkerMock!

    override func setUp() {
        super.setUp()
        setupMocks()
        setupInteractor()
    }

    func setupInteractor() {
        interactor = AddCityInteractor(worker: mockWorker, prenseter: mockPresenter)
    }

    func setupMocks() {
        mockPresenter = AddCityPresenterMock()
        mockWorker = AddCityWorkerMock()
    }
    
    func testGetCityList() {
        let expectedCity = fakeCityResponse()
        mockWorker.expectationForFetchWeatherCity = .success(expectedCity)
        mockPresenter.presentFetchCityList(response: FetchCityList.Response.init(model: expectedCity.response))
        interactor.getCityList()
        XCTAssertEqual(mockPresenter.presentFetchCityListResponse?.model.first?.lat, 30)
        XCTAssertEqual(mockPresenter.presentFetchCityListResponse?.model.first?.lng, -40)
        XCTAssertEqual(mockPresenter.presentFetchCityListResponse?.model.first?.name, "Test")
        XCTAssertEqual(mockPresenter.presentFetchCityListResponse?.model.first?.cityCode, "1234")
        XCTAssertEqual(mockPresenter.presentFetchCityListResponse?.model.first?.countryCode, "FR")
    }
}

extension AddCityInteractorTests {
    func fakeCityResponse() -> CityResponse {
        return CityResponse(response: [City(name: "Test", cityCode: "1234", lat: 30, lng: -40, countryCode: "FR")])
    }
}
