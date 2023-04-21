//
//  MeteoListBuilder.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

protocol MeteoListBuilderProtocol {
    func buildMeteoCityList(model: [MeteoCityProtocol]) -> [DisplayedMeteoCityList]
}

struct MeteoListBuilder: MeteoListBuilderProtocol {
    
    func buildMeteoCityList(model: [MeteoCityProtocol]) -> [DisplayedMeteoCityList] {
        
        return model.map { DisplayedMeteoCityList(cityName: buildCityName(name: $0.name), descriptionText: buildDescription(description: $0.weather.first?.description ?? ""), temp: buildTemp(temp: $0.main.temp), tempMin: buildTempMinMax(temp: $0.main.tempMin), tempMax: buildTempMinMax(temp: $0.main.tempMax), icon: buildIcon(image: $0.weather.first?.icon ?? "") ?? UIImage()) }
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
    
    private func buildTemp(temp: Double) -> NSAttributedString {
        let tempText = NSMutableAttributedString()
        tempText.append(NSAttributedString.make(string: getTempFor(temp),
                                            font: UIFont.boldSystemFont(ofSize: 22),
                                            color: .black))
        tempText.append(NSAttributedString.make(string: "°",
                                            font: UIFont.boldSystemFont(ofSize: 22),
                                            color: .black))
        return tempText
    }
    
    private func buildTempMinMax(temp: Double) -> NSAttributedString {
        let nameText = NSMutableAttributedString()
        nameText.append(NSAttributedString.make(string: getTempFor(temp),
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
        return String(format: "%.0f", temp - 273.15)
    }
}
