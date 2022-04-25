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
        HStack{
            Image(uiImage: familyMember.wrappedProfilePhoto )
                    .resizable()
                    .scaleEffect()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding()
            Text(familyMember.wrappedFirstName + " " + familyMember.wrappedLastName)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
        
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = PersistenceController.preview.container.viewContext
//        let member = FMember(context: viewContext)
//        CardView(familyMember: "Kelvin Tran")
//            .previewLayout(.fixed(width: 400, height: 60))
//    }
//}
