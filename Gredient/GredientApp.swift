//
//  GredientApp.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-02-22.
//

import SwiftUI

@main
struct GredientApp: App {
    //let persistenceController = PersistenceController.shared
    @StateObject private var dataController = DataController()
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
    
}
