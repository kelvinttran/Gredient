//
//  FamilyRow.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-02-22.
//

import SwiftUI

struct FamilyRow: View{
    var familyMember: Family
    
    var body: some View{
        HStack{
            familyMember.image
                .resizable()
                .frame(width:50, height: 50)
            Text(familyMember.name)
            Spacer()
        }
    }
}

//struct FamilyRow: View {
//    var body: some View {
//        HStack{
//            Image("mary")
//                .resizable()
//                .frame(width: 50, height: 50)
//            VStack(alignment: .leading){
//                Text("Mary Appleseed")
//                    .font(.title2)
//                Text("Allergies: ")
//                    .font(.caption)
//                    .foregroundColor(Color.gray)
//                Text("Restrictions: ")
//                    .font(.caption)
//                    .foregroundColor(Color.gray)
//            }
//            Spacer()
//        }
//    }
//}

struct FamilyRow_Previews: PreviewProvider {
    static var previews: some View {
        FamilyRow()
    }
}
