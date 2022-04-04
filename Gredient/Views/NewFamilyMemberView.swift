//
//  NewFamilyMemberView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-01.
//

import SwiftUI

struct NewFamilyMemberView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode

    @State var firstName = ""
    @State var lastName = ""
    @State var allergyName = ""
    @State var restrictionName = ""
    
    @StateObject var newFMember: FMember
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Family Member Information")){
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                Section(header: Text("Allergies")){
                    TextField("Add an Allergy", text: $allergyName)
                }
                Section(header: Text("Restrictions")){
                    TextField("Add a Restriction", text: $restrictionName)
                }
                Button(action: {
                    // DO SOMETHING HERE
                    newFMember.firstName = self.firstName
                    newFMember.lastName = self.lastName
                    
                    do{
                        try viewContext.save()
                        print("New Family Member Saved")
                        presentationMode.wrappedValue.dismiss()
                    } catch{
                        print(error.localizedDescription)
                    }
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
        let viewContext = PersistenceController.preview.container.viewContext
        let newFamilyMember = FMember(context: viewContext)
        newFamilyMember.firstName = "John"
        newFamilyMember.lastName = "Appleseed"
        return NewFamilyMemberView(newFMember: newFamilyMember)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
