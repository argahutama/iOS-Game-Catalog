//
//  GameDetailRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation

protocol GameDetailRepository {
    func getGame(
        id: Int,
        onSuccess: @escaping (_ game: Game?) -> Void,
        onFailure: @escaping (_ error: Error) -> Void
    )
}
