//
//  MeteoListInteractorTests.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

@testable import Meteo
import Foundation
import XCTest

class MeteoListInteractorTests: XCTestCase {
    
    var interactor: MeteoListInteractor!
    var mockPresenter: MeteoListPresenterMock!
    var mockWorker: MeteoListWorkerMock!

    override func setUp() {
        super.setUp()
        setupMocks()
        setupInteractor()
    }

    func setupInteractor() {
        interactor = MeteoListInteractor(worker: mockWorker, prenseter: mockPresenter)
    }

    func setupMocks() {
        mockPresenter = MeteoListPresenterMock()
        mockWorker = MeteoListWorkerMock()
    }

    func testFetchWeather() {
        let expectedWeather = fakeWeatherResponse()
        mockWorker.expectationForFetchWeatherCity = .success(expectedWeather)
        mockPresenter.presentFetchMeteoList(response: FetchWeather.Response.init(model: [expectedWeather]))
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.current.temperature, 10)
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.current.date, 1682248805)
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.current.weather.first?.main, "Rain")
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.daily.first?.date, 1682272800)
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.daily.first?.temperature.max, 10)
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.daily.first?.temperature.min, 5.23)
        XCTAssertEqual(mockPresenter.presentFetchMeteoListResponse?.model.first?.hourly.first?.temperature, 10)
    }
}

extension MeteoListInteractorTests {
    func fakeWeatherResponse() ->  WeatherResponse {
        let weatherDetail = [WeatherDetail(main: "Rain", description: "moderate rain", icon: "10n")]
        var weatherDaily = WeatherDaily()
        weatherDaily.date = 1682272800
        weatherDaily.temperature = Temperature(min: 5.23, max: 10)
        weatherDaily.weather = weatherDetail
        var weather = Weather()
        weather.date = 1682248805
        weather.temperature = 10
        weather.weather = weatherDetail
        return WeatherResponse(current: weather,
                               hourly: [weather],
                               daily: [weatherDaily],
                               cityName: "My position")
    }
}
