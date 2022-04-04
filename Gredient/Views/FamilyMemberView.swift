//
//  FamilyMemberView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI


struct FamilyMemberView: View {
    let familyMember: FMember
    
    var body: some View {
        List{
            Section(header: Text("Family Member Name")){
                Text(familyMember.wrappedFirstName)
                Text(familyMember.wrappedLastName)
            }
            Section(header: Text("Allergies")){
                ForEach(familyMember.allergyArray){allergy in
                    Text(allergy.wrappedName)
                }
            }
            Section(header: Text("Restrictions")){
                ForEach(familyMember.restrictionArray){restriction in
                    Text(restriction.wrappedName)
                }
            }
        }
        .navigationTitle("Member Details")
    }
}

struct FamilyMemberView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMemberView(familyMember: FMember())
    }
}
