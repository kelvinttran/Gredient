//
//  FamilyView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct FamilyView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var familyMembers: FetchedResults<FMember>
    @State var showNewFamilyMemberSheet = false
    
    var body: some View {
        VStack {
            List{
                ForEach(familyMembers, id: \.self){member in
                    Section(member.wrappedFirstName + " " + member.wrappedLastName){
                        ForEach(member.allergyArray, id: \.self){allergy in
                            Text(allergy.wrappedName)
                        }
                    }
                    
                }
            }
//            List{
//                ForEach(familyMembers, id: \.self){ member in
//                    NavigationLink(destination: FamilyMemberView(familyMember: member)){
//                        CardView(familyMember: member)
//                    }
//                }
//            }
            .navigationTitle("My Family")
            .navigationBarItems(trailing: Button(action:{
                print("Add new family member")
                
                showNewFamilyMemberSheet = true
            }, label:{
                Image(systemName: "plus")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showNewFamilyMemberSheet){
                NewFamilyMemberView(newFMember: FMember(context: viewContext))
            }
            Button("Add"){
                let newFMember = FMember(context:viewContext)
                newFMember.firstName = "Michelle"
                newFMember.lastName = "Tran"
                
                let newAllergy = Allergy(context:viewContext)
                
                newAllergy.name = "Hazelnuts"
                newFMember.addToAllergy(newAllergy)
                
                let newAllergy2 = Allergy(context:viewContext)
                newAllergy2.name = "Pecans"
                newFMember.addToAllergy(newAllergy2)
                                
                //let newAllergy = Allergy(context:viewContext)
                //newAllergy.name = "Hazelnuts"
                //newAllergy.member = FMember(context: viewContext)
                //newAllergy.member?.firstName = "Michelle"
                //newAllergy.member?.lastName = "Tran"
                
                //let newRestriction = Restriction(context: viewContext)
                //newRestriction.name = "Celiac Disease"
                //newRestriction.member = FMember(context: viewContext)
                //newRestriction.member?.firstName = "Michelle"
                //newRestriction.member?.lastName = "Tran"
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
