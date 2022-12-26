//
//  BaseField.swift
//  BFAI
//
//  Created by Arga Hutama on 19/12/22.
//

import SwiftUI

struct BaseField: View {

  let title: String
  let placeholder: String
  @Binding var text: String
  let onChange: (String) -> Void

  var body: some View {
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
