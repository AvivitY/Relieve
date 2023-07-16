//
//  LocationMapPinView.swift
//  Relieve
//
//  Created by Student25 on 08/07/2023.
//

import SwiftUI

struct LocationMapPinView: View {
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "toilet.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40,height: 40)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10,height: 10)
                .foregroundColor(accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y:-3)
                .padding(.bottom,40)
        }
    }
}

struct LocationMapPinView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapPinView()
    }
}
