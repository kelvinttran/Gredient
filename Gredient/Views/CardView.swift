//
//  CardView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct CardView: View {
    let familyMember: FMember
    
    var body: some View {
        HStack{
            Text(familyMember.wrappedFirstName + " " + familyMember.wrappedLastName)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(familyMember: FMember())
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
