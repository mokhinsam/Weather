//
//  LocationManager.swift
//  Weather
//
//  Created by Дарина Самохина on 25.03.2025.
//

import CoreLocation

enum LocationError: Error {
    case noPermission
    case errorByDefault
}

typealias Coordinates = (lat: Double, lon: Double)

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    var delegate: LocationManagerDelegate?
    
    private let locationManager = CLLocationManager()
    private var completion: ((Result<Coordinates, LocationError>) -> Void)?
    private var locationRequested = false
    
    override private init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation(with completion: @escaping (Result<Coordinates, LocationError>) -> Void) {
        if locationManager.authorizationStatus == .notDetermined {
            locationRequested = false
            locationManager.requestWhenInUseAuthorization()
        } else {
            print("Start updating...")
            locationRequested = true
            locationManager.requestLocation()
            self.completion = completion
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let coordinates = (lat: lat, lon: lon)
        self.completion?(.success(coordinates))
        print("Location received.")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            completion?(.failure(.errorByDefault))
        case .denied:
            completion?(.failure(.noPermission))
        default: break
        }
        print("didFailWithError \(error), \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if !locationRequested {
                delegate?.repeatRequestLocation()
            }
        default: break
        }
    }
}
