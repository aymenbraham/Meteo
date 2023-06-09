//
//  CityListModel.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import UIKit

protocol DisplayedCityListProtocol {
    var cityName: NSAttributedString { get set }
    var model: CityProtocol { get set }
}

struct DisplayedCityList: DisplayedCityListProtocol {
    var cityName: NSAttributedString
    var model: CityProtocol
}

struct Coordinate {
    let lat: Double
    let lon: Double
    let cityName: String
}

enum FetchCityList {
    struct Request {}

    struct Response {
        let model: [CityProtocol]
    }

    struct ViewModel {
        let displayedCityList: [DisplayedCityListProtocol]
    }
}

