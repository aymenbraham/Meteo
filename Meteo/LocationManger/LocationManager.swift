//
//  LocationManager.swift
//  Meteo
//
//  Created by aymen braham on 24/04/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var locationPermissionGranted = false
    private var completion: ((CLLocation?, Error?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        self.completion = completion
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                locationPermissionGranted = true
                locationManager.requestLocation()
            case .denied, .restricted:
                completion(nil, nil)
            @unknown default:
                break
            }
        } else {
            completion(nil, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationPermissionGranted = true
            locationManager.requestLocation()
        case .denied, .restricted:
            completion?(nil, nil)
        case .notDetermined:
            completion?(nil, nil)
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, locationPermissionGranted {
            completion?(location, nil)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil, error)
    }
}
