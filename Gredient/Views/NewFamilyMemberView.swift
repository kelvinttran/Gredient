//
//  NewFamilyMemberView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-01.
//

import SwiftUI

struct NewFamilyMemberView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var firstName = ""
    @State var lastName = ""
    @State var allergy = ""
    @State var restriction = ""
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Family Member Information")){
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                Section(header: Text("Allergies")){
                    TextField("Add an Allergy", text: $allergy)
                }
                Section(header: Text("Restrictions")){
                    TextField("Add a Restriction", text: $restriction)
                }
                Button(action: {
                    print("Save member")
                }){
                    Text("Save Family Member")
                }
            }
            .navigationTitle("New Family Member")
        }
    }
}

struct NewFamilyMemberView_Previews: PreviewProvider {
    static var previews: some View {
        NewFamilyMemberView()
    }
}
