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
        weather = [WeatherDetail(main: "",
                                 description: "",
                                 icon: "")]
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
    var feelsLike: Double
    var pressure: Int
    var humidity: Int
    var dewPoint: Double
    var clouds: Int
    var windSpeed: Double
    var windDeg: Int
    var weather: [WeatherDetail]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case clouds = "clouds"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
    }

    init() {
        date = 0
        temperature = 0.0
        feelsLike = 0.0
        pressure = 0
        humidity = 0
        dewPoint = 0.0
        clouds = 0
        windSpeed = 0.0
        windDeg = 0
        weather = []
    }
}
