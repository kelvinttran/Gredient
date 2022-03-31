//
//  Family.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-02-28.
//

import Foundation
import SwiftUI

struct Family: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    
    private var imageName: String
    var image: Image{
        Image(imageName)
    }
}
