//
//  MeteoDetailBuilder.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import UIKit

protocol MeteoDetailBuilderProtocol {
    func buildWeather(model: WeatherProtocol) -> DisplayedWeather
}

struct MeteoDetailBuilder: MeteoDetailBuilderProtocol {
    
    func buildWeather(model: WeatherProtocol) -> DisplayedWeather {
        return DisplayedWeather(current: buildCurrentWeather(model: model),
                                hourly:  buildDisplayedHourly(model: model.hourly),
                                daily: buildDisplayedDaily(model: model.daily))
    }
    
    private func buildCurrentWeather(model: WeatherProtocol) -> DisplayedCurrent {
        let current = model.current
        let daily = model.daily
        return DisplayedCurrent(cityNametext: buildAttributtedText(text: model.cityName ?? "", font: UIFont.boldSystemFont(ofSize: 25)),
                                temptext: buildAttributtedText(text: getTempFor(current.temperature), font: UIFont.boldSystemFont(ofSize: 25)),
                                descriptionText: buildAttributtedText(text: current.weather.first?.description ?? "", font: UIFont.boldSystemFont(ofSize: 25)),
                                tempMinText: buildAttributtedText(text: getTempFor(daily.first?.temperature.min ?? 0), font: UIFont.boldSystemFont(ofSize: 25)),
                                tempMaxText: buildAttributtedText(text: getTempFor(daily.first?.temperature.max ?? 0), font: UIFont.boldSystemFont(ofSize: 25)),
                                iconImage: UIImage(named: current.weather.first?.icon ?? "") ?? UIImage())
    }
    
    private func buildDisplayedHourly(model: [Weather]) -> [DisplayedHourly] {
        var displayedHourly: [DisplayedHourly] = []
        model.forEach({ hourly in
            displayedHourly.append(DisplayedHourly(timeText: buildAttributtedText(text: getTimeFor(hourly.date),
                                                                                                        font: UIFont.systemFont(ofSize: 17, weight: .semibold)),
                                                                         tempText: buildAttributtedText(text: getTempFor(hourly.temperature), font: UIFont.systemFont(ofSize: 17, weight: .semibold)),
                                           iconImage: UIImage(named: hourly.weather[0].icon) ?? UIImage()) )})
        return displayedHourly
    }
    
    private func buildDisplayedDaily(model: [WeatherDaily]) -> [DisplayedDaily] {
        var displayedDaily: [DisplayedDaily] = []
        model.forEach({ daily in
            let dayWithNumber = "\(getDayFor(daily.date)) \(getDayNumber(daily.date))"
            displayedDaily.append(DisplayedDaily(dayTex: buildAttributtedText(text: dayWithNumber, font: UIFont.systemFont(ofSize: 17, weight: .semibold)),
                                                 tempMinText: buildAttributtedText(text: getTempFor(daily.temperature.min), font: UIFont.systemFont(ofSize: 17, weight: .semibold)),
                                                 tempMaxText: buildAttributtedText(text: getTempFor(daily.temperature.max), font: UIFont.systemFont(ofSize: 17, weight: .semibold)),
                                                 iconImage: UIImage(named: daily.weather[0].icon) ?? UIImage()))
        })
        return displayedDaily
    }
    
    private func buildAttributtedText(text: String, font: UIFont) -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString.make(string: text,
                                                   font: font,
                                                   color: .black))
        return attributedText
    }
    
    private func getTempFor(_ temp: Double) -> String {
        return String(format: "%1.0f", temp)
    }
    
    private func getTimeFor(_ temp: Int) -> String {
        return Time.timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }
    
    private func getDayFor(_ temp: Int) -> String {
        return Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }
    
    private func getDayNumber(_ temp: Int) -> String {
        return Time.dayNumberFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }
}
