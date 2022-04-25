//
//  ProductIngredient+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-24.
//
//

import Foundation
import CoreData


extension ProductIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductIngredient> {
        return NSFetchRequest<ProductIngredient>(entityName: "ProductIngredient")
    }
    
    @NSManaged public var ingredientName: String?
    @NSManaged public var foodProduct: FoodProduct?
    
    public var wrappedIngredientName: String {
        ingredientName ?? "Unknown Ingredient Name"
    }

}

extension ProductIngredient : Identifiable {

}
