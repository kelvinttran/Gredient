//
//  FamilyMemberStore.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-10.
//

import Foundation
import SwiftUI

class FamilyMemberStore: ObservableObject{
    @Published var familyMembers: [FamilyMember] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("familyMembers.data")
    }
    
    static func load(completion: @escaping(Result<[FamilyMember], Error>)->Void){
        DispatchQueue.global(qos: .background).async{
            do{
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else{
                    DispatchQueue.main.async{
                        completion(.success([]))
                    }
                    return
                }
                let familyMembers = try JSONDecoder().decode([FamilyMember].self, from: file.availableData)
                DispatchQueue.main.async{
                    completion(.success(familyMembers))
                }
            } catch{
                DispatchQueue.main.async{
                    completion(.failure(error))
                }
            }
        }
    }
    static func save(familyMembers: [FamilyMember], completion: @escaping (Result<Int, Error>)->Void){
        DispatchQueue.global(qos: .background).async{
            do{
                let data = try JSONEncoder().encode(familyMembers)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async{
                    completion(.success(familyMembers.count))
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
