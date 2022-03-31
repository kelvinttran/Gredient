//
//  FamilyMemberEditView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct FamilyMemberEditView: View {
    @Binding var data: FamilyMember.Data
    @State private var newAllergyItem = ""
    
    var body: some View {
        Form{
            Section(header: Text("Family Member Info")){
                TextField("First Name", text: $data.firstName)
                TextField("Last Name", text: $data.lastName)
            }
            Section(header: Text("Allergies")){
                ForEach(data.allergies){allergy in
                    Text(allergy.item)
                }
                .onDelete {indices in
                    data.allergies.remove(atOffsets: indices)
                }
                HStack{
                    TextField("Add Allergy", text: $newAllergyItem)
                    Button(action:{
                        withAnimation{
                            let allergy = FamilyMember.Allergy(item: newAllergyItem)
                            data.allergies.append(allergy)
                            newAllergyItem = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add allergy")
                    }
                    .disabled(newAllergyItem.isEmpty)
                }
            }
        }
        
    }
}

struct FamilyMemberEditView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMemberEditView(data: .constant(FamilyMember.sampleData[0].data))
    }
}
