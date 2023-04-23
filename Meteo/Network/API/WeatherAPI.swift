//
//  WeatherAPI.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import Foundation

protocol WeatherAPIProtocol {
    typealias WeatherCompletion = (Result<WeatherResponse, Error>) -> Void
    func fetchWeather(lat: Double, lon: Double, completion: @escaping WeatherCompletion)
}

struct WeatherAPI: WeatherAPIProtocol {

    private let netWork: NetworkManagerProtocol
    private let baseURL = Constants.Strings.baseURL
    private let keyApi = Constants.Strings.keyAPI
    
    init(network: NetworkManagerProtocol) {
        self.netWork = network
    }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping WeatherCompletion) {
        guard let url = URL(string: "\(baseURL)/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&appid=\(keyApi)") else { return }
        netWork.request(fromURL: url, httpMethod: .get, completion: completion)
    }
}
