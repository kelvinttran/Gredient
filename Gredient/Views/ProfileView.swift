//
//  ProfileView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct ProfileView: View {
    @Binding var familyMembers: [FamilyMember]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewMemberView = false
    @State private var newMemberData = FamilyMember.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($familyMembers) { $familyMember in
                NavigationLink(destination:
                    FamilyMemberView(familyMember: $familyMember)){
                    CardView(familyMember: familyMember)
                }
                
            }
        }
        .navigationTitle("Appleseed Family")
        .toolbar{
            Button(action:{
                isPresentingNewMemberView = true
            }){
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Family Member")
        }
        .sheet(isPresented: $isPresentingNewMemberView){
            NavigationView{
                FamilyMemberEditView(data: $newMemberData)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Dismiss"){
                                isPresentingNewMemberView = false
                                newMemberData = FamilyMember.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                let newMember = FamilyMember(data: newMemberData)
                                familyMembers.append(newMember)
                                isPresentingNewMemberView = false
                                newMemberData = FamilyMember.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase){phase in
            if phase == .inactive {saveAction()}
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView(familyMembers: .constant(FamilyMember.sampleData), saveAction: {})
        }
    }
}
