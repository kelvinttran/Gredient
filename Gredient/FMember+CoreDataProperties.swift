//
//  FMember+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-01.
//
//

import Foundation
import CoreData


extension FMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FMember> {
        return NSFetchRequest<FMember>(entityName: "FMember")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var allergies: [String]?
    @NSManaged public var restrictions: [String]?
    @NSManaged public var id: UUID?

}

extension FMember : Identifiable {

}
