//
//  ProductView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-14.
//

import SwiftUI

struct APIResponse: Codable{
    var responses: [Response]
}

struct Response: Codable{
    var productName: String
    var ingredientList: [String]
}

struct ProductView: View {

    
    var body: some View {
        Text("Hello World!")
    }
    
    
    func loadData() async{
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/0062020003843") else{
            print("Invalid URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                print(decodedResponse)
                //responses = decodedResponse.responses
            }
            
        } catch{
            print("Invalid data")
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
