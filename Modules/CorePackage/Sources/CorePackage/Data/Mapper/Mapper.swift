//
//  Mapper.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import Foundation

func mapGamesResponseToPagingEntity(_ gamesResponse: GetGamesResponse) -> PagingEntity<GameEntity> {
    return PagingEntity<GameEntity>(
        items: gamesResponse.results?.map { game in mapGameDtoToEntity(game) } ?? [],
        count: gamesResponse.count ?? 0,
        nextPageUrl: gamesResponse.next,
        previousPageUrl: gamesResponse.previous
    )
}

func mapGameDtoToEntity(_ gameDto: GameDto) -> GameEntity {
    return GameEntity(
        id: gameDto.id ?? -1,
        name: gameDto.name ?? "",
        description: gameDto.description,
        released: gameDto.released,
        backgroundImage: gameDto.backgroundImage,
        rating: gameDto.rating,
        playtime: gameDto.playtime,
        genres: gameDto.genres?.map { genre in mapGenreDtoToEntity(genre) },
        isFavorite: gameDto.isFavorite ?? false
    )
}

func mapGameEntityToDto(_ gameEntity: GameEntity) -> GameDto {
    return GameDto(
        id: gameEntity.id,
        name: gameEntity.name,
        description: gameEntity.description,
        released: gameEntity.released,
        backgroundImage: gameEntity.backgroundImage,
        rating: gameEntity.rating,
        playtime: gameEntity.playtime,
        genres: gameEntity.genres?.map { genreDto in mapGenreEntityToDto(genreDto) },
        isFavorite: gameEntity.isFavorite
    )
}

private func mapGenreDtoToEntity(_ genreDto: GenreDto) -> GenreEntity {
    return GenreEntity(
        id: genreDto.id,
        name: genreDto.name ?? "",
        slug: genreDto.slug ?? "",
        domain: genreDto.domain,
        language: genreDto.language
    )
}

private func mapGenreEntityToDto(_ genreEntity: GenreEntity) -> GenreDto {
    return GenreDto(
        id: genreEntity.id,
        name: genreEntity.name,
        slug: genreEntity.slug,
        domain: genreEntity.domain,
        language: genreEntity.language
    )
}

func mapProfileDtoToEntity(_ profileDto: ProfileDto?) -> ProfileEntity {
    return ProfileEntity(
        name: profileDto?.name ?? "",
        profilePicture: profileDto?.profilePicture,
        city: profileDto?.city,
        workingAt: profileDto?.workingAt,
        position: profileDto?.position
    )
}

func mapProfileEntityToDto(_ profileEntity: ProfileEntity) -> ProfileDto {
    return ProfileDto(
        name: profileEntity.name,
        profilePicture: profileEntity.profilePicture,
        city: profileEntity.city,
        workingAt: profileEntity.workingAt,
        position: profileEntity.position
    )
}
