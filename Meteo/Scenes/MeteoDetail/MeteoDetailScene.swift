//
//  MeteoDetailScene.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import UIKit

enum MeteoDetailScene {
    case initialization(WeatherProtocol)

    func configure() -> UIViewController {
        switch self {
        case  let .initialization(weather):
            return configureMeteoDetail(weather: weather)
        }
    }

    private func configureMeteoDetail(weather: WeatherProtocol) -> UIViewController {
        let viewController = MeteoDetailViewController(nibName: "MeteoDetailViewController", bundle: nil)
        let builder = MeteoDetailBuilder()
        let presenter = MeteoDetailPresenter(viewController: viewController, builder: builder)
        let interactor = MeteoDetailInteractor(prenseter: presenter, weather: weather)
        let router = MeteoDetailRouter(viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
