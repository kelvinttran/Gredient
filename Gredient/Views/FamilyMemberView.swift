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
        Text("Family Member View")
        
    }
}

struct FamilyMemberView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMemberView(familyMember: FMember())
    }
}
