//
//  Config.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

struct Config {
    static let baseUrl = "https://api.rawg.io/api/"
    static func getApiKey() -> String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "Api Key") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
    }
}
