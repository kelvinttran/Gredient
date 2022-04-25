//
//  ProductCardView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-24.
//

import SwiftUI

struct ProductCardView: View {
    let foodProduct: FoodProduct
    
    var body: some View {
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
            .frame(width: 110, height: 110)
            
            Text(foodProduct.wrappedProductName)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
        
    }
    

}

//struct ProductCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCardView()
//    }
//}
