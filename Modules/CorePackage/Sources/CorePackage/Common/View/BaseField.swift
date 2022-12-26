//
//  BaseField.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import SwiftUI

public struct BaseField: View {
    public init(title: String, placeholder: String, text: Binding<String>, onChange: @escaping (String) -> Void) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.onChange = onChange
    }

    let title: String
    let placeholder: String
    @Binding var text: String
    let onChange: (String) -> Void

    public var body: some View {
        Text(title)
        TextField(placeholder, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .stroke(.gray, lineWidth: 1.0))
            .onChange(of: text) { newValue in
                onChange(newValue)
            }
    }
}
