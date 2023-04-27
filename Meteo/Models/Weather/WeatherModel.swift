//
//  WeatherModel.swift
//  Meteo
//
//  Created by aymen braham on 23/04/2023.
//

import Foundation
import UIKit

protocol DisplayedWeathertProtocol {
    var current: DisplayedCurrent { get set }
    var hourly: [DisplayedHourly] { get set }
    var daily: [DisplayedDaily] { get set }
}

struct DisplayedWeather: DisplayedWeathertProtocol {
    var current: DisplayedCurrent
    var hourly: [DisplayedHourly]
    var daily: [DisplayedDaily]
}

struct DisplayedCurrent {
    var cityNametext: NSAttributedString
    var temptext: NSAttributedString
    var descriptionText: NSAttributedString
    var tempMinText: NSAttributedString
    var tempMaxText: NSAttributedString
    var iconImage: UIImage
}

struct DisplayedHourly {
    var timeText: NSAttributedString
    var tempText: NSAttributedString
    var iconImage: UIImage
}

struct DisplayedDaily {
    var dayTex: NSAttributedString
    var tempMinText: NSAttributedString
    var tempMaxText: NSAttributedString
    var iconImage: UIImage
}

enum FetchWeather {
    struct Request {}

    struct Response {
        let model: [WeatherProtocol]
    }
    
    struct ResponseDetail {
        let model: WeatherProtocol
    }
    
    struct ViewModel {
        let displayedWeatherDetail: DisplayedWeathertProtocol
    }
}
