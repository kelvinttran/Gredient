//
//  FoodProduct+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-24.
//
//

import Foundation
import CoreData


extension FoodProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodProduct> {
        return NSFetchRequest<FoodProduct>(entityName: "FoodProduct")
    }

    @NSManaged public var barcode: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var productName: String?
    @NSManaged public var productIngredients: NSSet?
    @NSManaged public var productAdditives: NSSet?
    
    public var wrappedProductName: String {
        productName ?? "Unknown Product Name"
    }
    
    public var wrappedBarcode: String {
        barcode ?? "Unknown Barcode"
    }
    
    public var wrappedImageURL: String {
        imageURL ?? "Unknown Image URL"
    }
    
    public var productIngredientArray: [ProductIngredient] {
        let ingredientSet = productIngredients as? Set<ProductIngredient> ?? []
        return ingredientSet.sorted{
            $0.wrappedIngredientName < $1.wrappedIngredientName
        }
    }
    
    public var productAdditiveArray: [ProductAdditive]{
        let additiveSet = productAdditives as? Set<ProductAdditive> ?? []
        return additiveSet.sorted{
            $0.wrappedAdditiveName < $1.wrappedAdditiveName
        }
    }

}

// MARK: Generated accessors for productIngredients
extension FoodProduct {

    @objc(addProductIngredientsObject:)
    @NSManaged public func addToProductIngredients(_ value: ProductIngredient)

    @objc(removeProductIngredientsObject:)
    @NSManaged public func removeFromProductIngredients(_ value: ProductIngredient)

    @objc(addProductIngredients:)
    @NSManaged public func addToProductIngredients(_ values: NSSet)

    @objc(removeProductIngredients:)
    @NSManaged public func removeFromProductIngredients(_ values: NSSet)

}

// MARK: Generated accessors for productAdditives
extension FoodProduct {

    @objc(addProductAdditivesObject:)
    @NSManaged public func addToProductAdditives(_ value: ProductAdditive)

    @objc(removeProductAdditivesObject:)
    @NSManaged public func removeFromProductAdditives(_ value: ProductAdditive)

    @objc(addProductAdditives:)
    @NSManaged public func addToProductAdditives(_ values: NSSet)

    @objc(removeProductAdditives:)
    @NSManaged public func removeFromProductAdditives(_ values: NSSet)

}

extension FoodProduct : Identifiable {

}
