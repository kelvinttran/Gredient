//
//  FamilyMember.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import Foundation

struct FamilyMember: Identifiable, Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var allergies: [Allergy]
    var restrictions: [Restriction]
    
    init(id: UUID = UUID(), firstName: String, lastName: String, allergies: [String], restrictions: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.allergies = allergies.map {Allergy(item: $0)}
        self.restrictions = restrictions.map {Restriction(item: $0)}
    }
}

extension FamilyMember {
    struct Allergy: Identifiable, Codable{
        let id: UUID
        var item: String
    
        init (id: UUID = UUID(), item: String){
            self.id = id
            self.item = item
        }
    }
    
    struct Restriction: Identifiable, Codable{
        let id: UUID
        var item: String
    
        init (id: UUID = UUID(), item: String){
            self.id = id
            self.item = item
        }
    }
    
    struct Data {
        var firstName: String = ""
        var lastName: String = ""
        var allergies: [Allergy] = []
        var restrictions: [Restriction] = []
    }
    
    var data: Data{
        Data(firstName: firstName, lastName: lastName, allergies: allergies, restrictions: restrictions)
    }
    
    mutating func update(from data: Data){
        firstName = data.firstName
        lastName = data.lastName
        allergies = data.allergies
        restrictions = data.restrictions
    }
    
    init(data: Data){
        id = UUID()
        firstName = data.firstName
        lastName = data.lastName
        allergies = data.allergies
        restrictions = data.restrictions
    }
}

extension FamilyMember {
    static let sampleData: [FamilyMember] =
    [
        FamilyMember(firstName: "Mary", lastName: "Appleseed", allergies: ["Peanuts"], restrictions: ["Celiac Disease"]),
        FamilyMember(firstName: "John", lastName: "Appleseed", allergies: [], restrictions: ["Ulcerative Colitis"]),
        FamilyMember(firstName: "Annie", lastName: "Appleseed", allergies: ["Salmon", "Cuttlefish"], restrictions: ["Vegan"]),
        FamilyMember(firstName: "Kelvin", lastName: "Appleseed", allergies: [], restrictions: []),
        FamilyMember(firstName: "Jenna", lastName: "Appleseed", allergies: ["Flax Seed"], restrictions: [])
    ]
}
