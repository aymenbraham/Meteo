//
//  MeteoListModel.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation
import UIKit

protocol DisplayedMeteoCityListProtocol {
    var cityName: NSAttributedString { get set }
    var descriptionText: NSAttributedString { get set }
    var temp: NSAttributedString { get set }
    var tempMin: NSAttributedString { get set }
    var tempMax: NSAttributedString { get set }
    var icon: UIImage { get set }
    var model: WeatherProtocol { get set }
}

struct DisplayedMeteoCityList: DisplayedMeteoCityListProtocol {
    var cityName: NSAttributedString
    var descriptionText: NSAttributedString
    var temp: NSAttributedString
    var tempMin: NSAttributedString
    var tempMax: NSAttributedString
    var icon: UIImage
    var model: WeatherProtocol
}

enum FetchMeteoCityList {
    struct Request {}

    struct Response {}

    struct ViewModel {
        let displayedMeteoCityList: [DisplayedMeteoCityListProtocol]
    }
}
