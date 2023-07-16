//
//  LocationManager.swift
//  Relieve
//
//  Created by Student25 on 09/07/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @EnvironmentObject private var vm: LocationViewModel
    var locationManager : CLLocationManager?
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    

    override init() {
        super.init()
        checkIfLocationServiceIsEnabled()
    }

    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        }else{
            print("location service is unabled")
        }
    }
    
    private func checkStatus() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            print("ccc notDetermined")
        case .authorizedWhenInUse:
            print("ccc authorizedWhenInUse")
        case .authorizedAlways: print("ccc authorizedAlways")
        case .restricted: print("ccc restricted")
        case .denied: print("ccc denied")
        default: print("ccc unknown")
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkStatus()
    }
    
    func getAddressFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil)
                return
            }
            
            let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.country ?? "")"
            completion(address)
        }
    }
}
