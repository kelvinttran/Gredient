//
//  Restriction+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-02.
//
//

import Foundation
import CoreData


extension Restriction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restriction> {
        return NSFetchRequest<Restriction>(entityName: "Restriction")
    }

    @NSManaged public var name: String?
    @NSManaged public var member: FMember?
    
    public var wrappedName: String {
        name ?? "Unknown Restriction"
    }

}

extension Restriction : Identifiable {

}
