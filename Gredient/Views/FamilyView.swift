//
//  ProfileView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct FamilyView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var familyMembers: FetchedResults<FMember>
    @State var showNewFamilyMemberSheet = false
    //@FetchRequest(entity: FMember.entity(), sortDescriptors: []) var familyMembers: FetchedResults<FMember>
    
    var body: some View {
        VStack {
            List{
                ForEach(familyMembers, id: \.self){ member in
                    NavigationLink(destination: FamilyMemberView()){
                        CardView(familyMember: member)
                    }
                }
            }
            .navigationTitle("My Family")
            .navigationBarItems(trailing: Button(action:{
                print("Add new family member")
                showNewFamilyMemberSheet = true
            }, label:{
                Image(systemName: "plus")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showNewFamilyMemberSheet){
                NewFamilyMemberView()
            }
            Button("Add"){
                let newAllergy = Allergy(context:viewContext)
                newAllergy.name = "Hazelnuts"
                newAllergy.member = FMember(context: viewContext)
                newAllergy.member?.firstName = "Michelle"
                newAllergy.member?.lastName = "Tran"
                
                let newRestriction = Restriction(context: viewContext)
                newRestriction.name = "Celiac Disease"
                newRestriction.member = FMember(context: viewContext)
                newRestriction.member?.firstName = "Michelle"
                newRestriction.member?.lastName = "Tran"
            }
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FamilyView()
        }
    }
}
