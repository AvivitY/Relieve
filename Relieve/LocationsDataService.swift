import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            address: "123 Main Street",
            coordinates:CodableCoordinate(coordinate: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922)),
            isFree: true,
            cost:0,
            cleanliness: 3.5),
        Location(
            address: "456 Elm Avenue",
            coordinates: CodableCoordinate(coordinate:CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4769)),
            isFree: true,
            cost:0,
            cleanliness: 3.5),
        Location(
            address: "789 Oak Street",
            coordinates: CodableCoordinate(coordinate:CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833)),
            isFree: true,
            cost:0,
            cleanliness: 3.5)
    ]
    
}
