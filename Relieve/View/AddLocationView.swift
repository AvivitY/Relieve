//
//  AddLocationView.swift
//  Relieve
//
//  Created by Student25 on 10/07/2023.
//

import SwiftUI
import MapKit
struct AddLocationView: View {
    @Environment(\.dismiss) var dismiss
    @State var address: String = ""
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject private var vm :LocationViewModel
    @State var isFree: Bool = true
    @State var price: String = ""
    @State var cleanliness: String = ""
    var body: some View {
        NavigationView {
            VStack {
                cost
                Button {
                    let coor = locationManager.locationManager!.location!.coordinate
                   locationManager.getAddressFromCoordinates(latitude: coor.latitude, longitude: coor.longitude) { address in
                        if let address = address {
                            self.address = address
                            let loc = Location(address: address, coordinates: CodableCoordinate(coordinate: locationManager.locationManager!.location!.coordinate), isFree: isFree, cost: Double(price) ?? 0, cleanliness: Double(cleanliness) ?? 0)
                            Task{
                                try await DBM.shared.createLocation(location: loc)
                                vm.updateLocation{_ in }
                            }
                            dismiss()
                            print("Address: \(address)")
                        } else {
                            print("Unable to retrieve address")
                        }
                    }
                   
                }
                label:{
                    Text("Save".uppercased()).font(.headline)
                    .padding(10)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Spacer()
                
            }.padding().navigationTitle("Add new Facility")
        }.overlay(alignment: .topTrailing) {
            Button{
                dismiss()
            }label:{
                Image(systemName: "xmark.circle").resizable().font(.title2).foregroundColor(.primary).frame(width: 30,height: 30).padding()
            }
        }.presentationDetents([.medium])
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}

extension AddLocationView {
    private var cost: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: isFree ? "largecircle.fill.circle" : "circle").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isFree = true
                    }
                Text("Free")
            }
            HStack{
                Image(systemName: !isFree ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        isFree = false
                    }
                Text("Paid")
                Spacer()
                if !isFree {
                    Spacer()
                    Text("Cost")
                    TextField("$",text: $price)
                        .padding(.vertical,50)
                        .background(.thickMaterial)
                        .frame(width: 50,height: 50)
                        .cornerRadius(10)
                }
            }
            HStack{
                Text("Cleanliness")
                TextField("",text: $cleanliness)
                    .padding(.vertical,50)
                    .background(.thickMaterial)
                    .frame(width: 50,height: 50)
                    .cornerRadius(10)
            }
        }.padding()
    }
}
