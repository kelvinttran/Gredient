//
//  CardView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        HStack{
            Text("Kelvin Tran")
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
