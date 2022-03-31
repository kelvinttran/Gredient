//
//  GredientApp.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-02-22.
//

import SwiftUI

@main
struct GredientApp: App {
    @StateObject private var store = FamilyMemberStore()
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MainView(familyMembers: $store.familyMembers){}
        }
    }
    
//    var body: some Scene {
//        WindowGroup {
//            NavigationView{
//                MainView(familyMembers: $store.familyMembers){
//                    FamilyMemberStore.save(familyMembers: store.familyMembers){result in
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
//                }
//            }
//            .onAppear{
//                FamilyMemberStore.load {result in
//                    switch result{
//                        case .failure(let error):
//                            fatalError(error.localizedDescription)
//                        case .success(let familyMembers):
//                            store.familyMembers = familyMembers
//                        }
//                    }
//                }
//            }
//    }
    
//    var body: some Scene {
//        WindowGroup {
//            NavigationView{
//                ProfileView(familyMembers: $store.familyMembers){
//                    FamilyMemberStore.save(familyMembers: store.familyMembers){result in
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
//                }
//            }
//            .onAppear{
//                FamilyMemberStore.load {result in
//                    switch result{
//                    case .failure(let error):
//                        fatalError(error.localizedDescription)
//                    case .success(let familyMembers):
//                        store.familyMembers = familyMembers
//                    }
//                }
//            }
//        }
//    }
}
