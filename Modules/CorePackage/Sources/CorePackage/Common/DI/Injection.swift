//
//  Injection.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import CoreData

public final class Injection: NSObject {
    public static let sharedInstance = Injection()

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

    private func provideLocalDataSource() -> LocalDataSource {
        return LocalDataSourceImpl.sharedInstance(provideTaskContext())
    }

    private func provideRemoteDataSource() -> RemoteDataSource {
        return RemoteDataSourceImpl.sharedInstance()
    }

    private func provideGamesRepository() -> GamesRepository {
        return GamesRepositoryImpl.sharedInstance(provideRemoteDataSource())
    }

    private func provideGameDetailRepository() -> GameDetailRepository {
        return GameDetailRepositoryImpl.sharedInstance(provideRemoteDataSource())
    }

    private func provideFavoriteGameRepository() -> FavoriteGameRepository {
        return FavoriteGameRepositoryImpl.sharedInstance(provideLocalDataSource())
    }

    private func provideUserRepository() -> UserRepository {
        return UserRepositoryImpl.sharedInstance(provideLocalDataSource())
    }

    public func provideGamesUseCase() -> GamesUseCase {
        let repository = provideGamesRepository()
        return GameUseCaseImpl(repository: repository)
    }

    public func provideGameDetailUseCase() -> GameDetailUseCase {
        let repository = provideGameDetailRepository()

        return GameDetailUseCaseImpl(repository: repository)
    }

    public func provideFavoriteGameUseCase() -> FavoriteGameUseCase {
        let repository = provideFavoriteGameRepository()

        return FavoriteGameUseCaseImpl(repository: repository)
    }

    public func provideUserUseCase() -> UserUseCase {
        let repository = provideUserRepository()

        return UserUseCaseImpl(repository: repository)
    }
}
