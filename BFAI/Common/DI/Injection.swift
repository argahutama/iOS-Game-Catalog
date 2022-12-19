//
//  Injection.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import CoreData

final class Injection: NSObject {
    static let sharedInstance = Injection()
    
    private override init() {}
    
    private func providePersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "FavoriteGame")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }
    
    private func provideTaskContext() -> NSManagedObjectContext {
        let taskContext = providePersistentContainer().newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    private func provideGamesRepository() -> GamesRepository {
        let remote: RemoteDataSource = RemoteDataSourceImpl.sharedInstance()

        return GamesRepositoryImpl.sharedInstance(remote)
    }
    
    private func provideGameDetailRepository() -> GameDetailRepository {
        let remote: RemoteDataSource = RemoteDataSourceImpl.sharedInstance()

        return GameDetailRepositoryImpl.sharedInstance(remote)
    }
    
    private func provideFavoriteGameRepository() -> FavoriteGameRepository {
        let local: LocalDataSource = LocalDataSourceImpl.sharedInstance(provideTaskContext())

        return FavoriteGameRepositoryImpl.sharedInstance(local)
    }
    
    private func provideUserRepository() -> UserRepository {
        let local: LocalDataSource = LocalDataSourceImpl.sharedInstance(provideTaskContext())

        return UserRepositoryImpl.sharedInstance(local)
    }

    func provideGamesUseCase() -> GamesUseCase {
        let repository = provideGamesRepository()
        return GameUseCaseImpl(repository: repository)
    }

    func provideGameDetailUseCase() -> GameDetailUseCase {
        let repository = provideGameDetailRepository()
        return GameDetailUseCaseImpl(repository: repository)
    }
    
    func provideFavoriteGameUseCase() -> FavoriteGameUseCase {
        let repository = provideFavoriteGameRepository()
        return FavoriteGameUseCaseImpl(repository: repository)
    }
    
    func provideUserUseCase() -> UserUseCase {
        let repository = provideUserRepository()
        return UserUseCaseImpl(repository: repository)
    }
}
