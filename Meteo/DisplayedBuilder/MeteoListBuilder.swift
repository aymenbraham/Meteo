//
//  MeteoListBuilder.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

protocol MeteoListBuilderProtocol {
    func buildMeteoCityList(model: [WeatherProtocol]) -> [DisplayedMeteoCityList]
}

struct MeteoListBuilder: MeteoListBuilderProtocol {
    
    func buildMeteoCityList(model: [WeatherProtocol]) -> [DisplayedMeteoCityList] {
        var displayedMeteoCityList: [DisplayedMeteoCityList] = []
        let _ = model.map { displayedMeteoCityList.append(DisplayedMeteoCityList(cityName: buildCityName(name: $0.cityName ?? ""),
                                                                         descriptionText: buildDescription(description: $0.current.weather.first?.description ?? ""),
                                                                         temp: buildTemp(temp: getTempFor($0.current.temperature)),
                                                                         tempMin: buildTempMinMax(temp: getTempFor($0.daily.first?.temperature.min ?? 0)),
                                                                         tempMax: buildTempMinMax(temp: getTempFor($0.daily.first?.temperature.max ?? 0)),
                                                                         icon: buildIcon(image: $0.current.weather.first?.icon ?? "") ?? UIImage(),
                                                                         model: $0))}
        return displayedMeteoCityList
    }
        
    private func buildCityName(name: String) -> NSAttributedString {
        let nameText = NSMutableAttributedString()
        nameText.append(NSAttributedString.make(string: name,
                                                   font: UIFont.boldSystemFont(ofSize: 17),
                                                   color: .black))
        return nameText
    }
    
    private func buildDescription(description: String) -> NSAttributedString {
        let descriptionText = NSMutableAttributedString()
        descriptionText.append(NSAttributedString.make(string: description,
                                                       font: UIFont.systemFont(ofSize: 10, weight: .semibold),
                                                   color: .black))
        return descriptionText
    }
    
    private func buildTemp(temp: String) -> NSAttributedString {
        let tempText = NSMutableAttributedString()
        tempText.append(NSAttributedString.make(string: temp,
                                            font: UIFont.boldSystemFont(ofSize: 22),
                                            color: .black))
        tempText.append(NSAttributedString.make(string: "°",
                                            font: UIFont.boldSystemFont(ofSize: 22),
                                            color: .black))
        return tempText
    }
    
    private func buildTempMinMax(temp: String) -> NSAttributedString {
        let nameText = NSMutableAttributedString()
        nameText.append(NSAttributedString.make(string: temp,
                                            font:UIFont.systemFont(ofSize: 10, weight: .semibold),
                                            color: .black))
        nameText.append(NSAttributedString.make(string: "°",
                                            font:UIFont.systemFont(ofSize: 10, weight: .semibold),
                                            color: .black))
        return nameText
    }
    
    private func buildIcon(image: String) -> UIImage? {
        guard !image.isEmpty else { return nil }
        return UIImage(named: image)
    }
    
    private func getTempFor(_ temp: Double) -> String {
        return String(format: "%1.0f", temp)
    }
    
//   private func getTempFor(_ temp: Double) -> String {
//        return String(format: "%.0f", temp - 273.15)
//    }
}
