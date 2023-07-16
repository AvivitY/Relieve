//
//  DBM.swift
//  Relieve
//
//  Created by Student25 on 10/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DBM {
    static let shared = DBM()
    private let collection = Firestore.firestore().collection("facilities")
    
    func createLocation(location : Location) async throws{
        try facilityDocument(facilityId: location.id).setData(from: location, merge: false)
    }
    
    private func facilityDocument(facilityId: String) -> DocumentReference {
        collection.document(facilityId)
    }
    
    private func getLocation(locationId : String) async throws -> Location {
        try await facilityDocument(facilityId: locationId).getDocument(as:Location.self)
    }
    
    func getAllLocations() async throws -> [Location]{
        let snapshot = try await collection.getDocuments()
        
        var locations: [Location] = []

        for document in snapshot.documents {
            let location = try document.data(as: Location.self)
            locations.append(location)
        }
        return locations
    }
}
