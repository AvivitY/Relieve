//
//  LocationPreviewView.swift
//  Relieve
//
//  Created by Student25 on 08/07/2023.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationViewModel
    let location: Location
    var body: some View {
        //VStack(spacing: 16.0) {
        Button{
            vm.sheetLocation = location
        }
    label:{
        HStack{
            Spacer()
            Text(location.address).font(.title).foregroundColor(.primary)
            Spacer()
            VStack{
                Image("pin").resizable().aspectRatio(contentMode:.fit).frame(width: 30,height: 30).foregroundColor(.primary)
            }
        }.padding(16)
            .frame(height: 70)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.thickMaterial))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
            
        //}
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
        }
    }
}
