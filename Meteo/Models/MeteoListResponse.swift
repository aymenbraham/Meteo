//
//  MeteoListResponse.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoCityProtocol {
    var coord: Coord { get }
    var weather: [WeatherCity] { get }
    var main: MainCity { get }
    var timezone: Int { get }
    var name: String { get }
}

// MARK: - MeteoCity
struct MeteoCityResponse: Codable, MeteoCityProtocol {
    var coord: Coord
    var weather: [WeatherCity]
    var main: MainCity
    var timezone: Int
    var name: String
}

// MARK: - Coord
struct Coord: Codable {
    var lon: Double
    var lat: Double
}

// MARK: - Main
struct MainCity: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct WeatherCity: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
