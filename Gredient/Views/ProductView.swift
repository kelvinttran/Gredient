//
//  ProductView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-14.
//

import SwiftUI

struct ProductData: Decodable {
    var product: Product
}

struct Product: Decodable{
    var product_name: String
    var ingredients: [Ingredient]
    var image_front_thumb_url: String
    
}

struct Ingredient: Decodable{
    var id: String
    var text: String
}

struct ProductView: View {
    @Binding var scannedCode: [String]
    @State private var productData: ProductData?
    
    var body: some View {
        VStack{
            Text(productData?.product.product_name ?? "product name")
                .font(.largeTitle)
                .fontWeight(.medium)
                .onAppear(perform: loadData)
                .padding()
            Text(scannedCode[0])
            
            List(productData?.product.ingredients ?? [], id: \.id){item in
                Section(header: Text("Ingredients")){
                    Text(item.text)
                        .font(.headline)
                }
            }
            Spacer()
        }
        
    }
    
    private func loadData(){
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/" + scannedCode[0]) else{
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else {return}
            if let decodedData = try? JSONDecoder().decode(ProductData.self, from: data){
                DispatchQueue.main.async{
                    self.productData = decodedData
                }
            }
            print(url)
        }.resume()
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let code = ["1234567890123"]
        ProductView(scannedCode: .constant(code))
    }
}
