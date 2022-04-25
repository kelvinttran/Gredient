//
//  GredientApp.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-02-22.
//

import SwiftUI

@main
struct GredientApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
    
}
