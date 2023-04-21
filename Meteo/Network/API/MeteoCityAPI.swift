//
//  MeteoCityAPI.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoCityApiProtocol {
    typealias MeteoCityCompletion = (Result<MeteoCityResponse, Error>) -> Void
    func fetchMeteoCity(q: String, completion: @escaping MeteoCityCompletion)
}

struct MeteoCityAPI: MeteoCityApiProtocol {

    private let netWork: NetworkManagerProtocol
    private let baseURL = Constants.Strings.baseURL
    private let keyApi = Constants.Strings.keyAPI
    
    init(network: NetworkManagerProtocol) {
        self.netWork = network
    }
    
    func fetchMeteoCity(q: String, completion: @escaping MeteoCityCompletion) {
        guard let url = URL(string: "\(baseURL)/weather?q=\(q)&APPID=\(keyApi)") else { return }
        netWork.request(fromURL: url, httpMethod: .get, completion: completion)
    }
}
