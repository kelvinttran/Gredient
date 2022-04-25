//
//  ProductAdditive+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-24.
//
//

import Foundation
import CoreData


extension ProductAdditive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductAdditive> {
        return NSFetchRequest<ProductAdditive>(entityName: "ProductAdditive")
    }

    @NSManaged public var additiveName: String?
    @NSManaged public var foodProduct: FoodProduct?
    
    public var wrappedAdditiveName: String {
        additiveName ?? "Unknown Additive Name"
    }

}

extension ProductAdditive : Identifiable {

}
