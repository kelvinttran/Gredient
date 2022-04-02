//
//  FMember+CoreDataProperties.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-02.
//
//

import Foundation
import CoreData


extension FMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FMember> {
        return NSFetchRequest<FMember>(entityName: "FMember")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var allergy: NSSet?
    @NSManaged public var restriction: NSSet?
    
    public var wrappedFirstName: String {
        firstName ?? "Unknown First Name"
    }
    
    public var wrappedLastName: String {
        lastName ?? "Unknown Last Name"
    }
    
    public var allergyArray: [Allergy] {
        let set = allergy as? Set<Allergy> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var restrictionArray: [Restriction]{
        let set = restriction as? Set<Restriction> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for allergy
extension FMember {

    @objc(addAllergyObject:)
    @NSManaged public func addToAllergy(_ value: Allergy)

    @objc(removeAllergyObject:)
    @NSManaged public func removeFromAllergy(_ value: Allergy)

    @objc(addAllergy:)
    @NSManaged public func addToAllergy(_ values: NSSet)

    @objc(removeAllergy:)
    @NSManaged public func removeFromAllergy(_ values: NSSet)

}

// MARK: Generated accessors for restriction
extension FMember {

    @objc(addRestrictionObject:)
    @NSManaged public func addToRestriction(_ value: Restriction)

    @objc(removeRestrictionObject:)
    @NSManaged public func removeFromRestriction(_ value: Restriction)

    @objc(addRestriction:)
    @NSManaged public func addToRestriction(_ values: NSSet)

    @objc(removeRestriction:)
    @NSManaged public func removeFromRestriction(_ values: NSSet)

}

extension FMember : Identifiable {

}
