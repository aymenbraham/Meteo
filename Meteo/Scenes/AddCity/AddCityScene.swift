//
//  AddCityScene.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import UIKit

enum CityListScene {
    case initialization

    func configure() -> UIViewController {
        switch self {
        case  .initialization:
            return configureCityList()
        }
    }

    private func configureCityList() -> UIViewController {
        let viewController = AddCityViewController(nibName: "AddCityViewController", bundle: nil)
        let builder = CityListBuilder()
        let presenter = AddCityPresenter(viewController: viewController, builder: builder)
        let cityListApi = CityListAPI(network: NetworkManager())
        let cityDataStore = CityDataStore(dataStack: CoreDataStack())
        let worker = AddCityWorker(cityListApi: cityListApi, cityDataStore: cityDataStore)
        let interactor = AddCityInteractor(worker: worker, prenseter: presenter)
        let router = AddCityRouter(viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
