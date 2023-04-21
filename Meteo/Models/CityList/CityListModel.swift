//
//  CityListModel.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import UIKit

protocol DisplayedCityListProtocol {
    var cityName: NSAttributedString { get set }
}

struct DisplayedCityList: DisplayedCityListProtocol {
    var cityName: NSAttributedString
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

