//
//  GameUiMapper.swift
//  BFAI
//
//  Created by Arga Hutama on 21/12/22.
//

import Foundation

func mapGameEntityToUiModel(_ entity: GameEntity) -> Game {
    return Game(
        id: entity.id,
        name: entity.name,
        description: entity.description ?? "",
        released: entity.released ?? "",
        backgroundImage: entity.backgroundImage ?? "",
        rating: entity.rating,
        playtime: entity.playtime ?? 0,
        genreNames: entity.genres?.map { genre in
            genre.name
        } ?? [],
        isFavorite: entity.isFavorite == true
    )
}

func mapGameUiModelToEntity(_ game: Game) -> GameEntity {
    return GameEntity(
        id: game.id,
        name: game.name,
        description: game.description,
        released: game.released,
        backgroundImage: game.backgroundImage,
        rating: game.rating,
        playtime: game.playtime,
        genres: game.genreNames.map { name in
            GenreEntity(
                id: -1,
                name: name,
                slug: name,
                domain: nil,
                language: nil
            )
        },
        isFavorite: game.isFavorite == true
    )
}
