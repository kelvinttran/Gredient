//
//  CardView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-04.
//

import SwiftUI

struct CardView: View {
    let familyMember: FMember
    
    var body: some View {
        Text(familyMember.wrappedFirstName + " " + familyMember.wrappedLastName)
            .font(.title2)
            .multilineTextAlignment(.leading)
            .padding()
        Spacer()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let member = FMember(context: viewContext)
        CardView(familyMember: member)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
