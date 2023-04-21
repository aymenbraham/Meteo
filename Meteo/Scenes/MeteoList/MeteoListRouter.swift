//
//  MeteoListRouter.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import Foundation

protocol MeteoListRouting {
    
}

class MeteoListRouter: MeteoListRouting {
    
    private weak var viewController: MeteoListViewController?
    
    init(viewController: MeteoListViewController) {
        self.viewController = viewController
    }
}
