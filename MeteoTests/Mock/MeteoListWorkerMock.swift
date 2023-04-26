//
//  MeteoListWorkerMock.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

@testable import Meteo
import Foundation
import XCTest

class MeteoListWorkerMock: MeteoListWorkerProtocol {
    
    enum Expectation {
        enum FetchWeatherCity {
            case success(WeatherResponse)
            case failure(Error)
        }
        enum FetchAllCity {
            case success([CityDB])
            case failure(Error)
        }
        enum FetchWeather {
            case success([WeatherDetailDB])
            case failure(Error)
        }
    }
    
    var expectationForFetchWeatherCity: Expectation.FetchWeatherCity?
    var coreStackResult: CoreStackSaveResult?
    var expectationForFetchAllCity: Expectation.FetchAllCity?
    var cityDB: CityDB?
    var expectationForFetchWeather: Expectation.FetchWeather?
    var weatherDetail: WeatherDetailDB?
    
    func fetchWeatherCity(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        switch expectationForFetchWeatherCity {
        case .success(let weather)?:
            completion(.success(weather))
        case .failure(let error)?:
            completion(.failure(error))
        default:
            XCTFail("Unexpected expectation for fetchWeatherCity")
        }
    }
    
    func addCity(model: CityProtocol) -> CoreStackSaveResult {
        switch coreStackResult {
        case .success:
            return .success
        case .failure(let error):
            return .failure(error)
        case .noChanges:
            return .noChanges
        default:
            return .noChanges
        }
    }
    
    func fetchAllCity(completion: @escaping FetchLocalCityCompletion) {
        switch expectationForFetchAllCity {
        case .success(let cities):
            completion(.success(cities))
        case .failure(let error):
            completion(.failure(error))
        default:
            XCTFail("Unexpected expectation for fetchAllCity")
        }
    }
    
    func getCityWithCountryCode(cityCode: String) -> CityDB? {
        cityDB = CityDB()
        return cityDB
    }
    
    func addWeather(model: WeatherProtocol) -> CoreStackSaveResult? {
        switch coreStackResult {
        case .success:
            return .success
        case .failure(let error):
            return .failure(error)
        case .noChanges:
            return .noChanges
        default:
            return .noChanges
        }
    }
    
    func fetchWeather(completion: @escaping FetchLocalWeatherCompletion) {
        switch expectationForFetchWeather {
        case .success(let weather):
            completion(.success(weather))
        case .failure(let error):
            completion(.failure(error))
        default:
            XCTFail("Unexpected expectation for fetchWeather")
        }
    }
    
    func getWeatherWithCityName(cityName: String) -> WeatherDetailDB? {
        weatherDetail = WeatherDetailDB()
        return weatherDetail
    }
}
