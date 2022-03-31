//
//  MainView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var familyMembers: [FamilyMember]
    let saveAction: ()->Void
    
    var body: some View {
//        switch viewRouter.currentPage{
//        case .profilePage:
//            ProfileView(familyMembers: $familyMembers, saveAction: {})
//        case .scanPage:
//            ScanView()
//        case .historyPage:
//            HistoryView()
//        }
        TabView(){
            NavigationView{
                ProfileView(familyMembers: $familyMembers, saveAction: {})
            }
                .tag(0)
                .tabItem{
                    Label("Profile", systemImage: "person.crop.circle")
                }
            ScanView()
                .tag(1)
                .tabItem{
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
            HistoryView()
                .tag(2)
                .tabItem{
                    Label("History", systemImage: "clock")
                }
        }
    }
    
//    var body: some View {
//            TabView{
//                NavigationView{
//                    ProfileView(familyMembers: $familyMembers, saveAction: {})
//                }
//                .tabItem{
//                    Label("Profile", systemImage:
//                            "person.crop.circle")
//                }
//                ScanView()
//                    .tabItem{
//                        Label("Scan", systemImage: "barcode.viewfinder")
//                    }
//                HistoryView()
//                    .tabItem{
//                        Label("History", systemImage:
//                                "clock")
//                    }
//            }
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MainView(familyMembers: .constant(FamilyMember.sampleData), saveAction: {}).environmentObject(ViewRouter())
        }
    }
}
