//
//  CityListBuilder.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import UIKit

protocol CityListBuilderProtocol {
    func buildCityList(model: [CityProtocol]) -> [DisplayedCityList]
}

struct CityListBuilder: CityListBuilderProtocol {
    
    func buildCityList(model: [CityProtocol]) -> [DisplayedCityList] {
        return model.map({ DisplayedCityList(cityName: buildCityName(name: $0.name, countryCode: $0.countryCode)) })
    }
    
    private func buildCityName(name: String, countryCode: String) -> NSAttributedString {
        let nameText = NSMutableAttributedString()
        nameText.append(NSAttributedString.make(string: name,
                                                   font: UIFont.systemFont(ofSize: 17),
                                                   color: .black))
        nameText.append(NSAttributedString.make(string: ", ",
                                                   font: UIFont.systemFont(ofSize: 17),
                                                   color: .black))
        nameText.append(NSAttributedString.make(string: countryCode,
                                                   font: UIFont.systemFont(ofSize: 17),
                                                   color: .black))
        return nameText
    }
}
