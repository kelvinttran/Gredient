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
    @State private var checkOrX = ""

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
            List{
                Section(header: Text("Family Members")
                    .font(.headline)){
                        ForEach(familyMembers, id:\.self){member in
                            HStack{
                                Text(member.wrappedFirstName)
                                if (member.wrappedCheckOrX == ""){
                                    LoadingView()
                                }
                                else if (member.wrappedCheckOrX == "x.circle.fill"){
                                    Image(systemName: "\(member.wrappedCheckOrX)")
                                        .foregroundColor(.red)
                                }
                                else{
                                    Image(systemName: "\(member.wrappedCheckOrX)")
                                        .foregroundColor(.green)
                                }
                                
                                Spacer()
                            }
                        }
                    }
                Section(header: Text("Ingredients")){
                    ForEach(productData?.product.ingredients ?? [], id: \.id){item in
                        Text(item.text)
                    }
                }
                if (isLoadingIngredients){
                    LoadingView()
                }
                Section(header: Text("Additives")){
                    ForEach(additivesData?.tags ?? [], id: \.self){additive in
                        ForEach(productData?.product.additives_original_tags ?? [], id: \.self){code in
                            if (code == additive.id){
                                Text(additive.name)
                            }
                        }
                    }
                }
                if (isLoadingAdditives){
                    LoadingView()
                }
            }
            .onAppear(perform: loadAdditives)
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
            for fmember in familyMembers{
                if (!fmember.allergyArray.isEmpty){
                    checkAllergies(familyMember: fmember)
                }
                if (fmember.restrictionArray.contains(where: {$0.wrappedName == "Celiac Disease"})){
                    checkRestrictions(familyMember: fmember)
                }
                
            }
            
            DataController().addFoodProduct(
                foodProductName: self.productData?.product.product_name ?? "Unknown Product Name",
                foodProductBarcode: self.scannedCode[0],
                foodProductImage: self.productData?.product.image_front_thumb_url ?? "No Image URL",
                ingredients: self.productData?.product.ingredients ?? [],
                additives: self.additivesData?.tags ?? [],
                context: viewContext
            )

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
    
    private func checkAllergies(familyMember: FMember){
        DataController().setCheck(familyMember: familyMember, value: "", context: viewContext)
        for ingredient in productData?.product.ingredients ?? [] {
            if familyMember.allergyArray.contains(where: {$0.wrappedName.uppercased() == ingredient.text.uppercased()}){
                DataController().setCheck(familyMember: familyMember, value: "x.circle.fill", context: viewContext)
                break
            }
            else{
                DataController().setCheck(familyMember: familyMember, value: "checkmark.circle.fill", context: viewContext)
            }
        }
    }
    
    private func checkRestrictions(familyMember: FMember){
        let glutenList = ["Wheat Flour", "Rye", "Barley", "Malt", "Yeast", "Starch"]
        DataController().setCheck(familyMember: familyMember, value: "", context: viewContext)
        for ingredient in productData?.product.ingredients ?? [] {
            if glutenList.contains(where: {$0.uppercased() == ingredient.text.uppercased()}){
                DataController().setCheck(familyMember: familyMember, value: "x.circle.fill", context: viewContext)
                break
            }
            else{
                DataController().setCheck(familyMember: familyMember, value: "checkmark.circle.fill", context: viewContext)
            }
        }
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
