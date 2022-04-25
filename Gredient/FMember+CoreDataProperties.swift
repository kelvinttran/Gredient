import Foundation
import CoreData
import UIKit

extension FMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FMember> {
        return NSFetchRequest<FMember>(entityName: "FMember")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var allergy: NSSet?
    @NSManaged public var restriction: NSSet?
    @NSManaged public var profilePhoto: UIImage?
    @NSManaged public var checkOrX: String?
    
    
    public var wrappedFirstName: String {
        firstName ?? "Unknown First Name"
    }
    
    public var wrappedLastName: String {
        lastName ?? "Unknown Last Name"
    }
    
    public var wrappedProfilePhoto: UIImage{
        profilePhoto ?? UIImage(named: "blank-avatar")!
    }
    
    public var wrappedCheckOrX: String {
        checkOrX ?? ""
    }
    
    public var allergyArray: [Allergy] {
        let allergySet = allergy as? Set<Allergy> ?? []
        return allergySet.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var restrictionArray: [Restriction]{
        let restrictionSet = restriction as? Set<Restriction> ?? []
        return restrictionSet.sorted{
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
