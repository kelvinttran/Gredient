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
    var additives_original_tags: [String]
    var image_front_thumb_url: String
    
}

struct Ingredient: Decodable{
    var id: String
    var text: String
}

struct AdditivesData: Decodable, Hashable {
    var tags: [Additive]
}

struct Additive: Decodable, Hashable{
    var id: String
    var name: String
}

struct ProductView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: FMember.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FMember.firstName, ascending: true),
        ]
    ) var familyMembers: FetchedResults<FMember>
    @Binding var scannedCode: [String]
    @State private var productData: ProductData?
    @State private var additivesData: AdditivesData?
    @State private var isLoadingIngredients = false
    @State private var isLoadingAdditives = false

    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: productData?.product.image_front_thumb_url ?? "")){phase in
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

                Text(productData?.product.product_name ?? "No Product Found")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .onAppear(perform: loadData)
                    .padding()

                Spacer()
            }

            HStack{
                Text("Family Members")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
            }

            HStack{
                ForEach(familyMembers, id:\.self){member in
                    Text(member.wrappedFirstName)
                }
                Spacer()
            }


            ZStack {
                List{
                    Section(header: Text("Ingredients")){
                        ForEach(productData?.product.ingredients ?? [], id: \.id){item in
                            Text(item.text)
                        }
                    }
                }
                if (isLoadingIngredients){
                    LoadingView()
                }
            }

            ZStack{
                List{
                    Section(header: Text("Additives")){
                        ForEach(additivesData?.tags ?? [], id: \.self){additive in
                            ForEach(productData?.product.additives_original_tags ?? [], id: \.self){code in
                                if (code == additive.id){
                                    Text(additive.name)
                                }
                            }
                        }
                    }
                }
                if (isLoadingAdditives){
                    LoadingView()
                }
            }
            .onAppear(perform: loadAdditives)

            Spacer()
        }

    }
    
    private func loadData(){
        isLoadingIngredients = true
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/" + scannedCode[0] + ".json") else{
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
            isLoadingIngredients = false
        }.resume()
    }
    
    private func loadAdditives(){
        isLoadingAdditives = true
        guard let url = URL(string: "https://world.openfoodfacts.org/additives.json") else{
            print("Invalid additives URL")
            return
        }
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else {return}
            if let decodedData = try? JSONDecoder().decode(AdditivesData.self, from: data){
                DispatchQueue.main.async{
                    self.additivesData = decodedData
                }
            }
            print(url)
            isLoadingAdditives = false
        }.resume()
    }
}

struct LoadingView: View{
    var body: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .scaleEffect(2)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let code = ["1234567890123"]
        ProductView(scannedCode: .constant(code))
    }
}


