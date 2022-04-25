//
//  MainView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        TabView(){
            NavigationView{
                FamilyView()
            }
                .tag(0)
                .tabItem{
                    Label("My Family", systemImage: "person.3")
                }
            ScanView(barcode: ["SAMPLE BARCODE"])
                .tag(1)
                .tabItem{
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
            NavigationView{
                HistoryView()
            }
                .tag(2)
                .tabItem{
                    Label("History", systemImage: "clock")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MainView()
                .environmentObject(ViewRouter())
        }
    }
}
