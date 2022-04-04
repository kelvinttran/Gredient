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
                    ForEach(newFMember.allergyArray){allergy in
                        Text(allergy.wrappedName)
                    }
                    .onDelete{indices in
                        indices.forEach{(i) in
                            newFMember.removeFromAllergy(newFMember.allergyArray[i])
                            print("Removed allergy")
                        }
                    }
                    HStack{
                        TextField("Add Allergy", text: $allergyName)
                        Button(action:{
                            withAnimation{
                                let newAllergy = Allergy(context: viewContext)
                                newAllergy.name = self.allergyName
                                newFMember.addToAllergy(newAllergy)
                            }
                        }){
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(allergyName.isEmpty)
                    }
                    
                }
                Section(header: Text("Restrictions")){
                    ForEach(newFMember.restrictionArray){restriction in
                        Text(restriction.wrappedName)
                    }
                    .onDelete{indices in
                        indices.forEach{(i) in
                            newFMember.removeFromRestriction(newFMember.restrictionArray[i])
                            print("Removed restriction")
                        }
                    }
                    HStack{
                        TextField("Add Restriction", text: $restrictionName)
                        Button(action:{
                            withAnimation{
                                let newRestriction = Restriction(context: viewContext)
                                newRestriction.name = self.restrictionName
                                newFMember.addToRestriction(newRestriction)
                            }
                        }){
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(restrictionName.isEmpty)
                    }
                }
                Button(action: {
                    newFMember.firstName = self.firstName
                    newFMember.lastName = self.lastName
                    newFMember.id = UUID()
                    
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
