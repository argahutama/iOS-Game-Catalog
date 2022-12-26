//
//  StringExt.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import Foundation

extension String {
    public var htmlStripped: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
