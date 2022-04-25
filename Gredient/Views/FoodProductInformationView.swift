//
//  FoodProductInformationView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-24.
//

import SwiftUI

struct FoodProductInformationView: View {
    @Environment(\.managedObjectContext) var viewContext
    var foodProduct: FetchedResults<FoodProduct>.Element
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: foodProduct.wrappedImageURL)){phase in
                    if let image = phase.image{
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .padding()
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                    } else{
                        ProgressView()
                    }
                }
                .frame(width: 150, height: 150)

                Text(foodProduct.productName ?? "No Product Found")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    //.onAppear(perform: loadData)
                    .padding()

                Spacer()
            }
            List{
                Section(header: Text("Ingredients")){
                    ForEach(foodProduct.productIngredientArray, id: \.id){item in
                        Text(item.wrappedIngredientName)
                    }
                }
                Section(header: Text("Additives")){
                    ForEach(foodProduct.productAdditiveArray, id: \.id){item in
                        Text(item.wrappedAdditiveName)
                    }
                }
            }
        }
    }
}

//struct FoodProductInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodProductInformationView()
//    }
//}
