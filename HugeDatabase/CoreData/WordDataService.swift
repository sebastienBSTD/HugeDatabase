//
//  WordDataService.swift
//  HugeDatabase
//
//  Created by Pierre on 08/01/2023.
//

import Foundation
import CoreData

class WordDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "WordContainer"
    private let entityName: String = "WordEntity"
    
    @Published var savedEntities: [WordEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error )in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getWord()
        }
    }
    
    // MARK: - PRIVATE
    private func getWord() {
        let request = NSFetchRequest<WordEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities. \(error)")
        }
    }
}
