//
//  RatingView.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI

struct RatingView: View {
    private static let maxRating: Double = 5
    private static let color = Color.orange
    let rating: Double
    private let fullCount: Int
    private let emptyCount: Int
    private let halfFullCount: Int

    init(rating: Double) {
        self.rating = rating
        fullCount = Int(rating)
        emptyCount = Int(RatingView.maxRating - rating)
        halfFullCount = (Double(fullCount + emptyCount) < RatingView.maxRating) ? 1 : 0
    }

    var body: some View {
        HStack {
            ForEach(0..<fullCount, id: \.self) { _ in
                self.fullStar
            }
            ForEach(0..<halfFullCount, id: \.self) { _ in
                self.halfFullStar
            }
            ForEach(0..<emptyCount, id: \.self) { _ in
                self.emptyStar
            }
        }
    }

    private var fullStar: some View {
        Image(systemName: "star.fill").foregroundColor(RatingView.color)
    }

    private var halfFullStar: some View {
        Image(systemName: "star.lefthalf.fill").foregroundColor(RatingView.color)
    }

    private var emptyStar: some View {
        Image(systemName: "star").foregroundColor(RatingView.color)
    }
}
