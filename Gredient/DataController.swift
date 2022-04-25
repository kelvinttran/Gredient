//
//  DataController.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-08.
//

import Foundation
import CoreData
import UIKit

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "Gredient")
    
    init(){
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data Saved Successfully. WUHU!")
        } catch{
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addFamilyMember(firstName: String, lastName: String, context: NSManagedObjectContext){
        let familyMember = FMember(context: context)
        familyMember.id = UUID()
        familyMember.firstName = firstName
        familyMember.lastName = lastName
        
        save(context:context)
    }
    
    func editFamilyMember(familyMember: FMember, firstName: String, lastName: String, context: NSManagedObjectContext){
        familyMember.firstName = firstName
        familyMember.lastName = lastName
        
        save(context:context)
    }
    
    func addAllergy(familyMember: FMember, allergyName: String, context:NSManagedObjectContext){
        let allergy = Allergy(context: context)
        allergy.name = allergyName
        familyMember.addToAllergy(allergy)
        
        save(context:context)
    }
    
    func removeAllergy(familyMember: FMember, allergy: Allergy, context:NSManagedObjectContext){
        familyMember.removeFromAllergy(allergy)
        
        save(context:context)
    }
    
    func addRestriction(familyMember: FMember, restrictionName: String, context:NSManagedObjectContext){
        let restriction = Restriction(context: context)
        restriction.name = restrictionName
        familyMember.addToRestriction(restriction)
        
        save(context:context)
    }
    
    func removeRestriction(familyMember: FMember, restriction: Restriction, context:NSManagedObjectContext){
        familyMember.removeFromRestriction(restriction)
        
        save(context:context)
    }
    
    func updatePhoto(familyMember: FMember, photo: UIImage, context: NSManagedObjectContext){
        familyMember.profilePhoto = photo
        save(context:context)
    }
    
    func addFoodProduct(foodProductName: String, foodProductBarcode: String, foodProductImage: String, ingredients: [Ingredient], additives: [Additive], context: NSManagedObjectContext){
        let foodProduct = FoodProduct(context: context)
        foodProduct.productName = foodProductName
        foodProduct.barcode = foodProductBarcode
        foodProduct.imageURL = foodProductImage
        
        for ingredient in ingredients{
            let productIngredient = ProductIngredient(context:context)
            productIngredient.ingredientName = ingredient.text
            foodProduct.addToProductIngredients(productIngredient)
        }
        
        for additive in additives {
            let productAdditive = ProductAdditive(context: context)
            productAdditive.additiveName = additive.name
            foodProduct.addToProductAdditives(productAdditive)
        }
        
        save(context:context)
    }
    
    func setCheck(familyMember: FMember, value: String, context: NSManagedObjectContext){
        familyMember.checkOrX = value
        save(context:context)
    }
}
