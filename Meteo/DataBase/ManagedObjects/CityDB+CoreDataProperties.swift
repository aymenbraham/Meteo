//
//  CityDB+CoreDataProperties.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation
import CoreData

public extension CityDB {
    @nonobjc static func fetchRequest() -> NSFetchRequest<CityDB> {
        return NSFetchRequest<CityDB>(entityName: "City")
    }
    
    @nonobjc static func fetchRequest(cityCode: String) -> NSFetchRequest<CityDB> {
        let fetchRequest = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityCode = %@", cityCode)
        return fetchRequest
    }
    
    @NSManaged var name: String
    @NSManaged var cityCode: String
    @NSManaged var countryCode: String
    @NSManaged var lat: Double
    @NSManaged var lng: Double
}
