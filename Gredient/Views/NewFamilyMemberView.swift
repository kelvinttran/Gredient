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

    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Family Member Information")){
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                Button(action: {
                    DataController().addFamilyMember(firstName: self.firstName, lastName: self.lastName, context: viewContext)
                    
                    do{
                        try viewContext.save()
                        print("New Family Member Saved")
                        presentationMode.wrappedValue.dismiss()
                    } catch{
                        print(error.localizedDescription)
                    }
                }){
                    HStack{
                        Spacer()
                        Text("Create New Family Member")
                        Spacer()
                    }
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
