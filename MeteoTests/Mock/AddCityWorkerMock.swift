//
//  AddCityWorkerMock.swift
//  MeteoTests
//
//  Created by aymen braham on 26/04/2023.
//

@testable import Meteo
import Foundation
import XCTest

class AddCityWorkerMock: CityListWorkerProtocol {
    
    enum Expectation {
        enum FetchCity {
            case success(CityResponse)
            case failure(Error)
        }
        enum FetchAllCity {
            case success([CityDB])
            case failure(Error)
        }
    }
    
    var expectationForFetchWeatherCity: Expectation.FetchCity?
    var coreStackResult: CoreStackSaveResult?
    var expectationForFetchAllCity: Expectation.FetchAllCity?
    var cityDB: CityDB?
    
    func fetchCity(completion: @escaping (Result<CityResponse, Error>) -> Void) {
        switch expectationForFetchWeatherCity {
        case .success(let city)?:
            completion(.success(city))
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
}
