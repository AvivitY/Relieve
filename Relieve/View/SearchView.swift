//
//  SearchView.swift
//  Relieve
//
//  Created by Student25 on 13/07/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewmodel: LocationSearchViewModel
    @Binding var showLocationSearchView: Bool
    @State private var location = ""
    var body: some View {
        VStack{
            HStack{ 
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
                TextField("Search..",text:$viewmodel.queryFragment )
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .autocorrectionDisabled()
            }.background(.thickMaterial)
                .cornerRadius(10)
                .padding()
                .padding(.top,70)
            Divider()
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewmodel.results, id: \.self){ result in
                        SearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                viewmodel.selectLocation(result)
                                showLocationSearchView.toggle()
                            }
                    }
                }
            }
        }.overlay(alignment: .topLeading){
            backButton.padding()
        }.padding().ignoresSafeArea()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showLocationSearchView: .constant(false)).environmentObject(LocationSearchViewModel())
    }
}

extension SearchView {
    private var backButton: some View {
        Button{
            withAnimation(.spring()){
                showLocationSearchView.toggle()
            }
        } label:{
            Image(systemName: "arrow.backward.circle.fill")
                .resizable()
                .frame(width: 50,height: 50)
        }
    }
}
