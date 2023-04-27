//
//  WeatherResponse.swift
//  Meteo
//
//  Created by aymen braham on 23/04/2023.
//

import Foundation

protocol WeatherProtocol {
    var current: Weather { get }
    var hourly: [Weather] { get }
    var daily: [WeatherDaily] { get }
    var cityName: String? { get set }
}

// MARK: - WeatherResponse
struct WeatherResponse: Codable, WeatherProtocol {
    var current: Weather
    var hourly: [Weather]
    var daily: [WeatherDaily]
    var cityName: String?
    
    static func empty() -> WeatherResponse {
        WeatherResponse(
            current: Weather(),
            hourly: [Weather](repeating: Weather(),
                              count: 24),
            daily: [WeatherDaily](repeating: WeatherDaily(),
                                  count: 8)
        )
    }
}

struct Temperature: Codable {
    var min: Double
    var max: Double
}

struct WeatherDaily: Codable {
    var date: Int
    var temperature: Temperature
    var weather: [WeatherDetail]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case weather = "weather"
    }

    init() {
        date = 0
        temperature = Temperature(min: 0.0, max: 0.0)
        weather = []
    }
}

struct WeatherDetail: Codable {
    var main: String
    var description: String
    var icon: String
}

struct Weather: Codable {
    var date: Int
    var temperature: Double
    var weather: [WeatherDetail]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case weather = "weather"
    }

    init() {
        date = 0
        temperature = 0.0
        weather = []
    }
}
