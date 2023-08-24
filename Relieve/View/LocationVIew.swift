//
//  LocationVIew.swift
//  Relieve
//
//  Created by Student25 on 08/07/2023.
//

import SwiftUI
import MapKit
struct LocationVIew: View {
    @State private var showAddView: Bool = false
    @State private var loading: Bool = true
    @State private var showLocationSearchView = false
    @EnvironmentObject var searchViewmodel: LocationSearchViewModel
    @EnvironmentObject private var vm :LocationViewModel
    @StateObject var locationManager = LocationManager()
    @State var showPopUp :Bool = false
    var body: some View {
        ZStack {
           if let coordinate = searchViewmodel.selectedLocationCoordinate{
               Text("hi").foregroundColor(Color.white.opacity(0)).onAppear{
                   vm.updateMapRegion(location: coordinate)
               }
           }
            if showLocationSearchView{
                SearchView(showLocationSearchView: $showLocationSearchView)
            }else{
                VStack {
                    ZStack{
                        mapLayer.ignoresSafeArea()
                        
                        VStack(spacing:0){
                            header.padding()
                            
                            Spacer()
                        }
                    }
                    locationList
                }.overlay(alignment: .bottom){
                    addButton
                }
            }
        }
    }

}

struct LocationVIew_Previews: PreviewProvider {
    static var previews: some View {
        LocationVIew().environmentObject(LocationViewModel()).environmentObject(LocationSearchViewModel())
    }
}

extension LocationVIew{
    private var header: some View{
        HStack(){
            Text(searchViewmodel.selectedLocation ?? "Search..")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "magnifyingglass")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                    }
                .background(.thickMaterial)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation(.spring()){
                        showLocationSearchView.toggle()
                    }
                }
            Button{
                if(locationManager.locationManager?.location?.coordinate) != nil
                {
                    vm.updateMapRegion(location: (locationManager.locationManager?.location!.coordinate)!)
                }
                searchViewmodel.selectedLocation = nil
                }
            label:{
                Image(systemName: "scope")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                        
                    }.background(.thickMaterial)
                .cornerRadius(10)
        }.frame(height: 55)
            .shadow(color:Color.blue.opacity(0.3) ,radius: 20,x:0,y:15)
        
    }
    private var mapLayer :some View {
        Map(coordinateRegion: $vm.mapRegion,showsUserLocation: true, annotationItems: vm.locations, annotationContent: {location in MapAnnotation(coordinate: location.coordinates.coordinate){
            LocationMapPinView()
                .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                .shadow(radius: 10)
                .onTapGesture {
                    vm.showLocation(location: location)
                }
        }}).accentColor(Color(.systemPink))
    }
    
    private var addButton : some View {
        Button (){
            showAddView.toggle()
        }label:{
            Image(systemName: "plus").resizable().scaledToFit().frame(width: 35,height: 35)
                .foregroundColor(.white)
                .padding(20)
                .background(Color.accentColor)
                .cornerRadius(55)
                .shadow(radius: 10)
        }.sheet(isPresented: $showAddView){
            AddLocationView()
        }
    }
    
    private var locationList : some View {
        ZStack {
            if loading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            }
            VStack {
                ScrollView{
                    LazyVStack(spacing: 0){
                        if !loading{
                            ForEach(vm.locations){ location in
                                Button{
                                    showPopUp.toggle()
                                }label:{
                                    LocationPreviewView(location: location)
                                        .padding()
                                    
                                }
                            }
                        }
                    }.task {
                        vm.updateLocation { success in
                            loading = false
                        }
                    }.sheet(item: $vm.sheetLocation, onDismiss: nil){
                        location in LocationDetailView(location: location)
                    }
                }
                Divider().frame(height:1).overlay(Color.gray)
            }.padding(.bottom,40)
        }.onAppear{
            if(locationManager.locationManager?.location?.coordinate) != nil
            {
                vm.updateMapRegion(location: (locationManager.locationManager?.location!.coordinate)!)
            }
        }
    }
}
