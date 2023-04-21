//
//  CityResponse.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

// MARK: - CityResponse
struct CityResponse: Codable {
    let response: [City]
}


// MARK: - City
protocol CityProtocol {
    var name: String { get }
    var cityCode: String { get }
    var lat: Double { get }
    var lng: Double { get }
    var countryCode: String { get }
}

struct City: Codable, CityProtocol {
    var name: String
    var cityCode: String
    var lat: Double
    var lng: Double
    var countryCode: String

    enum CodingKeys: String, CodingKey {
        case name
        case cityCode = "city_code"
        case lat, lng
        case countryCode = "country_code"
    }
}
