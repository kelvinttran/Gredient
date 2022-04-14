//
//  FamilyMemberView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import SwiftUI


struct FamilyMemberView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    
    @State private var isEditing = false
    
    var familyMember: FetchedResults<FMember>.Element
    
    @State var firstName = ""
    @State var lastName = ""
    @State var allergyName = ""
    @State var restrictionName = ""
    
    var body: some View {
        Form{
            Section(header: Text("Family Member Name")){
                TextField("\(familyMember.wrappedFirstName)", text: $firstName)
                    .onAppear{
                        firstName = familyMember.wrappedFirstName
                    }
                TextField("\(familyMember.wrappedLastName)", text: $lastName)
                    .onAppear{
                        lastName = familyMember.wrappedLastName
                    }
            }
            Section(header: Text("Allergies")){
                ForEach(familyMember.allergyArray){allergy in
                    Text(allergy.wrappedName)
                }
                .onDelete{indices in
                    indices.forEach{(i) in
                        DataController().removeAllergy(familyMember: familyMember, allergy: familyMember.allergyArray[i], context: viewContext)
                        print("Removed allergy")
                    }
                }
                HStack{
                    TextField("Add Allergy...", text: $allergyName)
                    Button(action:{
                        withAnimation{
                            DataController().addAllergy(familyMember: familyMember, allergyName: self.allergyName, context: viewContext)
                            self.allergyName = ""
                        }

                    }){
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(allergyName.isEmpty)
                }

            }
            Section(header: Text("Restrictions")){
                ForEach(familyMember.restrictionArray){restriction in
                    Text(restriction.wrappedName)
                }
                .onDelete{indices in
                    indices.forEach{(i) in
                        DataController().removeRestriction(familyMember: familyMember, restriction: familyMember.restrictionArray[i], context: viewContext)
                        print("Removed restriction")
                    }
                }
                HStack{
                    TextField("Add Restriction...", text: $restrictionName)
                    Button(action:{
                        withAnimation{
                            DataController().addRestriction(familyMember: familyMember, restrictionName: self.restrictionName, context: viewContext)
                            self.restrictionName = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(restrictionName.isEmpty)
                }
            }
        }
        .onChange(of: editMode!.wrappedValue, perform: { value in
          if value.isEditing {
             // Entering edit mode (e.g. 'Edit' tapped)
              isEditing.toggle()
          } else {
             // Leaving edit mode (e.g. 'Done' tapped)
              DataController().editFamilyMember(familyMember: familyMember, firstName: self.firstName, lastName: self.lastName, context: viewContext)

              isEditing.toggle()
          }
        })
        .disabled(!isEditing)
        .navigationTitle("Member Details")
        .navigationBarItems(trailing: EditButton())
    }
}

struct FamilyMemberView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMemberView(familyMember: FMember())
    }
}
