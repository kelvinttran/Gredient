//
//  FamilyView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct FamilyView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: FMember.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FMember.firstName, ascending: true),
        ]
    ) var familyMembers: FetchedResults<FMember>
    @State var showNewFamilyMemberSheet = false
    
    var body: some View {
        VStack {
            List{
                ForEach(familyMembers, id: \.self){member in
                    NavigationLink(destination: FamilyMemberView(familyMember: member)){
                        CardView(familyMember: member)
                    }
                }
                .onDelete(perform: removeFMember)
            }
            .navigationTitle("My Family")
            .navigationBarItems(trailing: Button(action:{
                print("Add new family member")
                showNewFamilyMemberSheet = true
            }, label:{
                Image(systemName: "person.crop.circle.badge.plus")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showNewFamilyMemberSheet, onDismiss:{
                print("Sheet dismissed.")

            }){
                NewFamilyMemberView()
            }
        }
    }
    
    func removeFMember(at offsets: IndexSet){
        for index in offsets{
            let familyMember = familyMembers[index]
            viewContext.delete(familyMember)
        }
        do{
            try viewContext.save()
            
        } catch{
            print("Error saving to viewContext.")
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
