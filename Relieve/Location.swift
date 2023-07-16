//
//  Location.swift
//  Relieve
//
//  Created by Student25 on 08/07/2023.
//

import Foundation
import MapKit
struct Location : Codable, Identifiable, Equatable{
    let address : String
    let coordinates : CodableCoordinate
    let isFree : Bool
    let cost : Double
    let cleanliness: Double
    var id : String{
        String(coordinates.latitude+coordinates.longitude)
    }
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

struct CodableCoordinate: Codable {
    let latitude: Double
    let longitude: Double

    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
