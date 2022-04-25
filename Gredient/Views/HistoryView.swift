//
//  HistoryView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-24.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: FoodProduct.entity(),
        sortDescriptors: []
    ) var foodProducts: FetchedResults<FoodProduct>
    
    @State private var isShowingAlert = false
    @State private var isPresented = false
    
    var body: some View {
        List{
            ForEach(foodProducts, id: \.self){product in
                NavigationLink(destination: FoodProductInformationView(foodProduct: product)){
                    ProductCardView(foodProduct: product)
                }
            }
            .onDelete(perform: removeProduct)
        }
        .navigationTitle("History")
        .navigationBarItems(trailing: Button(action:{
            print("Clear history")
            isShowingAlert = true
        }, label:{
            Text("Clear")
                .foregroundColor(Color.red)
        }))
        .alert(isPresented: $isShowingAlert){
            Alert(
                title: Text("Are you sure you would like to clear the history?"),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Clear History")){
                    print("Clearing history...")
                    removeAllProducts()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func removeProduct(at offsets: IndexSet){
        for index in offsets{
            let foodProduct = foodProducts[index]
            viewContext.delete(foodProduct)
        }
        do{
            try viewContext.save()
            
        } catch{
            print("Error saving to viewContext.")
        }
    }
    
    func removeAllProducts(){
        for product in foodProducts{
            viewContext.delete(product)
        }
        do{
            try viewContext.save()
        } catch{
            print("Error saving to viewContext")
        }
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView()
//    }
//}
