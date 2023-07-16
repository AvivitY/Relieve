//
//  SearchResultCell.swift
//  Relieve
//
//  Created by Student25 on 13/07/2023.
//

import SwiftUI

struct SearchResultCell: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack{
            Image(systemName: "map.circle.fill")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 40,height: 40)
            VStack(alignment: .leading){
                Text(title).font(.body)
                Text(subtitle).font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
        }.padding()
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultCell(title: "Coffee", subtitle: "123 main st")
    }
}
