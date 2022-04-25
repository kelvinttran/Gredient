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

    @NSManaged public var productName: String?
    @NSManaged public var barcode: String?
    @NSManaged public var imageURL: String?

    public var wrappedProductName: String {
        productName ?? "Unknown Product Name"
    }
    
    public var wrappedBarcode: String {
        barcode ?? "Unknown Barcode"
    }
    
    public var wrappedImageURL: String {
        imageURL ?? "Unknown Image URL"
    }
    
}

extension FoodProduct : Identifiable {

}
