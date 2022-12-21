//
//  LocalDataSource.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import CoreData
import RxSwift

protocol LocalDataSource {
    func getAllFavoriteGames() -> Observable<[GameDto]>
    func addFavorite(game: GameDto) -> Observable<Void>
    func findGameData(gameId: Int) -> Observable<Bool>
    func removeFavorite(gameId: Int) -> Observable<Void>
    func set(newProfile profile: ProfileDto)
    func getProfile() -> ProfileDto?
    func sync()
}

final class LocalDataSourceImpl: LocalDataSource {
    private let taskContext: NSManagedObjectContext

    private init(taskContext: NSManagedObjectContext) {
        self.taskContext = taskContext
    }

    static let sharedInstance: (NSManagedObjectContext) -> LocalDataSource = { taskContext in
        return LocalDataSourceImpl(taskContext: taskContext)
    }

    private func getMaxId(completion: (_ maxId: Int) -> Void) {
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

    func getAllFavoriteGames() -> Observable<[GameDto]> {
        return Observable<[GameDto]>.create { observer in
            self.taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
                do {
                    let results = try self.taskContext.fetch(fetchRequest)
                    var favoriteGames: [GameDto] = []
                    for result in results {
                        let game: GameDto = GameDto(
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

    func addFavorite(game: GameDto) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.taskContext.performAndWait {
                if let entity = NSEntityDescription.entity(forEntityName: "FavoriteGame", in: self.taskContext) {
                    let data = NSManagedObject(entity: entity, insertInto: self.taskContext)

                    self.getMaxId { (id) in
                        data.setValue(id + 1, forKey: "id")
                        data.setValue(game.id, forKey: "gameId")
                        data.setValue(game.name, forKey: "name")
                        data.setValue(game.released, forKey: "released")
                        data.setValue(game.backgroundImage, forKey: "backgroundImage")
                        data.setValue(game.playtime, forKey: "playtime")
                        data.setValue(game.rating, forKey: "rating")

                        do {
                            try self.taskContext.save()
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

    func findGameData(gameId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            self.taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
                do {
                    if try self.taskContext.fetch(fetchRequest).first != nil {
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
            self.taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
                fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")

                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount

                if let batchDeleteResult = try? self.taskContext.execute(
                    batchDeleteRequest
                ) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
                    observer.onNext(Void())
                }
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }

    func set(newProfile profile: ProfileDto) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: "profile")
        }
    }

    func getProfile() -> ProfileDto? {
        if let data = UserDefaults.standard.object(
            forKey: "profile"
        ) as? Data, let profile = try? JSONDecoder().decode(
            ProfileDto.self, from: data
        ) {
            return profile
        }
        return ProfileDto()
    }

    func sync() {
        UserDefaults.standard.synchronize()
    }
}
