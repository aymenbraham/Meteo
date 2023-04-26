//
//  MeteoDetailInteractorTests.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

@testable import Meteo
import Foundation
import XCTest

class MeteoDetailInteractorTests: XCTestCase {
    
    var interactor: MeteoDetailInteractor!
    var mockPresenter: MeteoDetailPresenterMock!
    
    
    override func setUp() {
        super.setUp()
        setupMocks()
        setupInteractor()
    }

    func setupInteractor() {
        interactor = MeteoDetailInteractor(prenseter: mockPresenter, weather: fakeWeather())
    }

    func setupMocks() {
        mockPresenter = MeteoDetailPresenterMock()
    }
    
    func testGetWeather() {
        let expectedWeather = fakeWeather()
        interactor.getWeather()
        mockPresenter.presentMeteoDetail(response: FetchWeather.ResponseDetail.init(model: expectedWeather))
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.cityName, "My position")
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.current.temperature, 10)
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.current.date, 1682248805)
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.current.weather.first?.main, "Rain")
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.daily.first?.date, 1682272800)
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.daily.first?.temperature.max, 10)
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.daily.first?.temperature.min, 5.23)
        XCTAssertEqual(mockPresenter.presentMeteoDetailResponse?.model.hourly.first?.temperature, 10)
    }
}

extension MeteoDetailInteractorTests {
    func fakeWeather() ->  WeatherProtocol {
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
