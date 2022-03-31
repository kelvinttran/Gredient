//
//  CardView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct CardView: View {
    let familyMember: FamilyMember
    var body: some View {
        HStack{
            Text(familyMember.firstName + " " + familyMember.lastName)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var member = FamilyMember.sampleData[0]
    static var previews: some View {
        CardView(familyMember: member)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
