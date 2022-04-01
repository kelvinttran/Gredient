//
//  ProfileView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI

struct FamilyView: View {
    @State var showNewFamilyMemberSheet = false
    var body: some View {
        List{
            Text("Family")
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
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FamilyView()
        }
    }
}
