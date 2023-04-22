//
//  CityDataStore.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation
import CoreData

protocol CityDataSourceProtocol {
    typealias FetchLocalCityCompletion = (Result<[CityDB], Error>) -> Void
    func addCity(model: CityProtocol) -> CoreStackSaveResult
    func fetchAllCity(completion: @escaping FetchLocalCityCompletion)
    func getCityWithCountryCode(cityCode: String) -> CityDB?
}

struct CityDataStore: CityDataSourceProtocol {
        
    private let dataStack: CoreDataStackProtocol
    
    init(dataStack: CoreDataStackProtocol) {
        self.dataStack = dataStack
    }
    
    func getCityWithCountryCode(cityCode: String) -> CityDB? {
        if let fetchResult = try? dataStack.managedContext.fetch(CityDB.fetchRequest(cityCode: cityCode)) {
            return fetchResult.first
        } else {
            return nil
        }
    }
    
    func addCity(model: CityProtocol) -> CoreStackSaveResult {
        // We check if the City is already in the base if yes we update it
        guard let city = getCityWithCountryCode(cityCode: model.cityCode) else {
            let city = CityDB(context: dataStack.managedContext)
            city.populate(model: model)
            return dataStack.saveContext()
        }
        city.populate(model: model)
        return dataStack.saveContext()
    }

    func fetchAllCity(completion: @escaping FetchLocalCityCompletion) {
        let cityFetchRequest: NSFetchRequest<CityDB> = CityDB.fetchRequest()
        let asyncFetchRequest = NSAsynchronousFetchRequest<CityDB>(fetchRequest: cityFetchRequest) { result in
            guard let citys = result.finalResult else {
                completion(.success([]))
                return
            }
            completion(.success(citys))
        }
        do {
            try dataStack.managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
}
