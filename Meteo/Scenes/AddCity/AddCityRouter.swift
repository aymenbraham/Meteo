//
//  AddCityRouter.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation

protocol CityListRouting {
    func dismissViewController(fromCanel: Bool)
}

class AddCityRouter: CityListRouting {
    
    private weak var viewController: AddCityViewController?
    
    init(viewController: AddCityViewController) {
        self.viewController = viewController
    }
    
    func dismissViewController(fromCanel: Bool) {
        viewController?.dismiss(animated: true)
    }
}
