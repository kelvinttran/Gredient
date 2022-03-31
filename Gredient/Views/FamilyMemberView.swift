//
//  FamilyMemberView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI


struct FamilyMemberView: View {
    @Binding var familyMember: FamilyMember
    
    @State private var data = FamilyMember.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List{
            Section(header: Text("Allergies")){
                Label("Allergy Section", systemImage: "timer")
            }
            Section(header: Text("Restrictions")){
                Label("Restrictions Section", systemImage: "timer")
            }
        }
        .navigationTitle(familyMember.firstName + " " + familyMember.lastName)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                FamilyMemberEditView(data: $data)
                    .navigationTitle(Text("Edit Family Member"))
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                    }
                    .toolbar{
                        ToolbarItem(placement: .confirmationAction){
                            Button("Done"){
                                isPresentingEditView = false
                                print(familyMember.data)
                            }
                        }
                    }
            }
        }
    }
}

struct FamilyMemberView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FamilyMemberView(familyMember: .constant(FamilyMember.sampleData[0]))
        }
    }
}
