//
//  BindingExt.swift
//  BFAI
//
//  Created by Arga Hutama on 24/09/22.
//

import SwiftUI

extension Binding {
    public func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
