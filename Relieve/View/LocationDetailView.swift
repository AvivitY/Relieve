//
//  LocationDetailView.swift
//  Relieve
//
//  Created by Student25 on 08/07/2023.
//

import SwiftUI

struct LocationDetailView: View {
    @EnvironmentObject private var vm: LocationViewModel
    let location : Location

    var body: some View {
        NavigationView{
            VStack() {
                Text(location.address)
                    .font(
                        .system(size: 30,
                                weight: .bold,
                                design: .rounded)
                    ).padding()
                Text("Coordinates: \(String(format: "%.2f", location.coordinates.latitude)), \(String(format: "%.2f", location.coordinates.longitude))").font(.headline).padding()
                Text("Cleanliness: \(String(format: "%.1f", location.cleanliness))").font(.headline).padding()
                Button(action: {
                    vm.openGoogleMaps(with: location.address)
                }) {
                    Image("google-maps").resizable().frame(width: 50,height: 50).aspectRatio(contentMode: .fit).padding()
                }
            }}
        .overlay(alignment: .topTrailing) {
            Button{
                vm.sheetLocation = nil
            }label:{
                Image(systemName: "xmark.circle").font(.title2).padding(8).foregroundColor(.primary).frame(width: 50,height: 50)
            }
        }.presentationDetents([.medium])
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
    }
}
