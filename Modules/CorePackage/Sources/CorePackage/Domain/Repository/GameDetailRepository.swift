//
//  GameDetailRepository.swift
//  BFAI
//
//  Created by Arga Hutama on 18/12/22.
//

import Foundation
import RxSwift

protocol GameDetailRepository {
    func getGame(id: Int) -> Observable<GameEntity>
}
