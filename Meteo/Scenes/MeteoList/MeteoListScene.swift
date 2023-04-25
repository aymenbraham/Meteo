//
//  MeteoListScene.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

enum MeteoListScene {
    case initialization

    func configure() -> UIViewController {
        switch self {
        case  .initialization:
            return configureMeteoList()
        }
    }

    private func configureMeteoList() -> UIViewController {
        let viewController = MeteoListViewController(nibName: "MeteoListViewController", bundle: nil)
        let builder = MeteoListBuilder()
        let presenter = MeteoListPresenter(viewController: viewController, builder: builder)
        let cityApi = WeatherAPI(network: NetworkManager())
        let cityDataStore = CityDataStore(dataStack: CoreDataStack())
        let weatherDataStore = WeatherDataStore(dataStack: CoreDataStack())
        let worker = MeteoListWorker(weatherApi: cityApi, cityDataStore: cityDataStore, weatherDataStore: weatherDataStore)
        let interactor = MeteoListInteractor(worker: worker, prenseter: presenter)
        let router = MeteoListRouter(viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
