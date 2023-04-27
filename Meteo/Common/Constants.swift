//
//  Constants.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

class Constants {
    
    class Strings {
        static let keyAPI = "926247ac53ed30b659cab42495a479fd"
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let baseUrlCity = "https://airlabs.co/api/v9"
        static let keyAPICity = "97e492a0-47ef-4646-8b17-99ed7dae78b7"
        static let meteoListTableViewCell = "MeteoListTableViewCell"
        static let cityListTableViewCell = "CityListTableViewCell"
        static let hourlyCollectionViewCell = "HourlyCollectionViewCell"
        static let dataNeedsRefresh = Notification.Name("dataNeedsRefresh")
        static let errorAPITitle = "Error API"
        static let errorAPIMessage = "Failed to fetch data from server. Please check your internet connection and try again"
        static let connectionErrorTitle = "Connection Error"
        static let connectionErrorMessage = "Unable to establish a connection. Please check your internet connection and try again."
        static let positionErrorTitle = "Position Error"
        static let positionErrorMessage = "Unable to get your Position. Please check your internet connection, kill the App and try again."
    }
    
    class Colors {
        static let appUpMainColor = UIColor(red: 135 / 255, green: 206 / 255, blue: 250 / 255, alpha: 1)
        static let appDownMainColor = UIColor(red: 30 / 255, green: 144 / 255, blue: 255 / 255, alpha: 1)
        static let gradientAPP = [appUpMainColor.cgColor, appDownMainColor.cgColor]
    }
}
