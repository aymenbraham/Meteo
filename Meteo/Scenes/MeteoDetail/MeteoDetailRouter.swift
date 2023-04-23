//
//  MeteoDetailRouter.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import Foundation

protocol MeteoDetailRouting {
    
}

class MeteoDetailRouter: MeteoDetailRouting {
    
    private weak var viewController: MeteoDetailViewController?
    
    init(viewController: MeteoDetailViewController) {
        self.viewController = viewController
    }
}
