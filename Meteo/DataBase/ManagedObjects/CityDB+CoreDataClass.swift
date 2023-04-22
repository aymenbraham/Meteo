//
//  CityDB+CoreDataClass.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation
import CoreData

@objc(CityDB)
public class CityDB: NSManagedObject {
    
    func populate(model: CityProtocol) {
        name = model.name
        cityCode = model.cityCode
        lat = model.lat
        lng = model.lng
        countryCode = model.countryCode
    }
}
