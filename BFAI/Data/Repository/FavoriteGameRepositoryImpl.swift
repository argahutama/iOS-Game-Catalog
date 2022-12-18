//
//  FavoriteGameRepositoryImpl.swift
//  BFAI
//
//  Created by Arga Hutama on 23/09/22.
//

import Foundation
import CoreData
import RxSwift

class FavoriteGameRepositoryImpl: FavoriteGameRepository {
    lazy var persistentContainer: NSPersistentContainer = {
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
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    private func getMaxId(completion: (_ maxId: Int) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastData = try taskContext.fetch(fetchRequest)
                if let data = lastData.first, let position = data.value(forKey: "id") as? Int {
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllFavoriteGames() -> Observable<[Game]> {
        return Observable<[Game]>.create { observer in
            let taskContext = self.newTaskContext()
            
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
                do {
                    let results = try taskContext.fetch(fetchRequest)
                    var favoriteGames: [Game] = []
                    for result in results {
                        let game: Game = Game(
                            id: result.value(forKeyPath: "gameId") as? Int,
                            name: result.value(forKeyPath: "name") as? String,
                            description: nil,
                            released: result.value(forKeyPath: "released") as? String,
                            backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                            rating: result.value(forKeyPath: "rating") as? Double,
                            playtime: result.value(forKeyPath: "playtime") as? Int,
                            genres: nil,
                            isFavorite: true
                        )
                        
                        favoriteGames.append(game)
                    }
                    observer.onNext(favoriteGames)
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func addFavorite(game: Game) -> Observable<Void> {
        return Observable<Void>.create { observer in
            let taskContext = self.newTaskContext()
            
            taskContext.performAndWait {
                if let entity = NSEntityDescription.entity(forEntityName: "FavoriteGame", in: taskContext) {
                    let data = NSManagedObject(entity: entity, insertInto: taskContext)
                    
                    self.getMaxId { (id) in
                        data.setValue(id + 1, forKey: "id")
                        data.setValue(game.id, forKey: "gameId")
                        data.setValue(game.name, forKey: "name")
                        data.setValue(game.released, forKey: "released")
                        data.setValue(game.backgroundImage, forKey: "backgroundImage")
                        data.setValue(game.playtime, forKey: "playtime")
                        data.setValue(game.rating, forKey: "rating")
                        
                        do {
                            try taskContext.save()
                            observer.onNext(Void())
                            observer.onCompleted()
                        } catch let error as NSError {
                            observer.onError(error)
                        }
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func findData(gameId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
                do {
                    if let _ = try taskContext.fetch(fetchRequest).first {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onNext(false)
                        observer.onCompleted()
                    }
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func removeFavorite(gameId: Int) -> Observable<Void> {
        return Observable<Void>.create { observer in
            let taskContext = self.newTaskContext()
            
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
                fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
                
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
                    observer.onNext(Void())
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
