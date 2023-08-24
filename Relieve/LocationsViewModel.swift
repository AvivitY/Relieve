//
//  LocationsViewModel.swift
//  Relieve
//
//  Created by Student25 on 08/07/2023.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject{
    @StateObject var locationManager = LocationManager()
    //default location
    let locationy = Location(address: "default", coordinates: CodableCoordinate(coordinate: CLLocationCoordinate2D(latitude: 32.21, longitude: 34.86)), isFree: true, cost: 0, cleanliness: 4.5)
    //all locations
    @Published var locations: [Location]
    //current location on map
    @Published var mapLocation: Location? {
        didSet{
            updateMapRegion(location: mapLocation!.coordinates.coordinate)
        }
    }
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    @Published var sheetLocation : Location? = nil
    
    init(){
        self.locations = [Location]()
        self.locations.append(locationy)
        //self.mapLocation = locations.first!
        self.updateMapRegion(location: locationy.coordinates.coordinate)
        //self.updateMapRegion(location: (locationManager.locationManager?.location!.coordinate)!)
    }
    
    func updateMapRegion(location: CLLocationCoordinate2D){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: location, span: mapSpan)
        }
    }
    
    func showLocation(location : Location){
        withAnimation(.easeInOut){
            mapLocation = location
        }
    }
    
    func showCurrentRegion(){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: (locationManager.locationManager?.location!.coordinate)!, span: mapSpan)
        }
    }
    
    func updateLocation(completion: @escaping (Bool) -> Void){
        Task{
            locations = try await DBM.shared.getAllLocations()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(true)
        }
    }
    
    func openGoogleMaps(with address: String) {
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "comgooglemaps://?q=\(encodedAddress)"
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL")
        }
    }

    
}
