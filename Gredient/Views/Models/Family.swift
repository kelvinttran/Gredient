//
//  Family.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-08.
//

import Foundation

struct Family: Identifiable{
    let id: UUID
    var familyMembers: [FamilyMember]
}
