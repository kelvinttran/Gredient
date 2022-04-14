//
//  Allergy+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-02.
//
//

import Foundation
import CoreData


extension Allergy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Allergy> {
        return NSFetchRequest<Allergy>(entityName: "Allergy")
    }

    @NSManaged public var name: String?
    @NSManaged public var member: FMember?
    
    public var wrappedName: String {
        name ?? "Unknown Allergy"
    }
}

extension Allergy : Identifiable {

}
