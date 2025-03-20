//
//  CoreDataManager.swift
//  DigiHunt
//
//  Created by Sahil ChowKekar on 3/10/25.
//

import CoreData
import Foundation

protocol CoreDataManagerAction {
    func saveDataIntoDatabase(digimonList: [Digimon]) async throws
    func fetchDataFromDatabase() async throws -> [DigimonEntity]
}

//class CoreDataManager: CoreDataManagerAction {
//
//    let viewContext = PersistenceController.shared.container.viewContext  // this is main thread context
//
//    func saveDataIntoDatabase(digimonList: [Digimon]) async throws {
//
//        try await deleteAllData()
//
//        digimonList.forEach { (digimon) in
//            let digimonEntity = DigimonEntity(context: viewContext)
//            digimonEntity.name = digimon.name
//            digimonEntity.img = digimon.img
//            digimonEntity.level = digimon.level
//        }
//        do {
//            try viewContext.save()
//            print("Saving Context into Database")
//        } catch {
//            print(error.localizedDescription)
//            throw error
//        }
//
//    }
//
//    func fetchDataFromDatabase() async throws -> [DigimonEntity] {
//        var request: NSFetchRequest<DigimonEntity> =
//            DigimonEntity.fetchRequest()
//
//        return try viewContext.fetch(request)
//    }
//
//    private func deleteAllData() async throws {
//        let dbList = try await fetchDataFromDatabase()
//
//        dbList.forEach { (digimon) in
//            viewContext.delete(digimon)
//        }
//        try viewContext.save()
//
//        print("Deleting All Data from Database")
//
//    }
//}

class CoreDataManager: CoreDataManagerAction {

//    let viewContext = PersistenceController.shared.container.viewContext  // this is main thread context

    func saveDataIntoDatabase(digimonList: [Digimon]) async throws {

        try await deleteAllData()

        try await PersistenceController.shared.container.performBackgroundTask { // this for background thread
            privateContext in
            digimonList.forEach { (digimon) in
                let digimonEntity = DigimonEntity(context: privateContext)
                digimonEntity.name = digimon.name
                digimonEntity.img = digimon.img
                digimonEntity.level = digimon.level
            }
            do {
                try privateContext.save()
                print("Saving Context into Database")
            } catch {
                print(error.localizedDescription)
                throw error
            }

        }

    }

    func fetchDataFromDatabase() async throws -> [DigimonEntity] {
        try await PersistenceController.shared.container.performBackgroundTask {
            privateContext in
            let request: NSFetchRequest<DigimonEntity> =
                DigimonEntity.fetchRequest()

            return try privateContext.fetch(request)
        }
    }

    private func deleteAllData() async throws {
        let dbList = try await fetchDataFromDatabase()
        try await PersistenceController.shared.container.performBackgroundTask {
            privateContext in

            dbList.forEach { (digimon) in
                privateContext.delete(digimon)
            }
            try privateContext.save()

            print("Deleting All Data from Database")

        }
    }
}
