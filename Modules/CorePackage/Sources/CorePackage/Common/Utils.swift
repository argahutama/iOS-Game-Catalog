//
//  Utils.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

public class Utils {
    public static func formattedDateFromString(
        dateString: String?,
        withFormat format: String = "dd MMMM yyyy"
    ) -> String {
        guard let dateString = dateString else { return "" }

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {
          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format
          return outputFormatter.string(from: date)
        }

        return ""
    }
}
