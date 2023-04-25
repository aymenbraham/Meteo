//
//  CityListAPI.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

protocol CityListApiProtocol {
    typealias CityCompletion = (Result<CityResponse, Error>) -> Void
    func fetchMeteoCity(completion: @escaping CityCompletion)
}

struct CityListAPI: CityListApiProtocol {

    private let netWork: NetworkManagerProtocol
    private let baseURL = Constants.Strings.baseUrlCity
    private let keyApi = Constants.Strings.keyAPICity
    
    init(network: NetworkManagerProtocol) {
        self.netWork = network
    }
    
    func fetchMeteoCity(completion: @escaping CityCompletion) {
        guard let url = URL(string: "\(baseURL)/cities?name=&api_key=\(keyApi)") else { return }
        netWork.request(fromURL: url, httpMethod: .get, completion: completion)
    }
}
