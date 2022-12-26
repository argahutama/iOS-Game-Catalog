//
//  ContentView.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI
import Game
import Profile

struct ContentView: View {
    var body: some View {
        HomePage(onAboutClicked: {
            AboutPage()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
