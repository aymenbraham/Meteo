//
//  ErrorModel.swift
//  Meteo
//
//  Created by aymen braham on 27/04/2023.
//

import Foundation

protocol ModelErrorProtocol {
    var title: String { get set }
    var message: String { get set }
}

struct ModelError: ModelErrorProtocol, Error {
    var title: String
    var message: String
}
