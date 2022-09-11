//
//  HTMLFormattedText.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import WebKit
import SwiftUI

struct HTMLFormattedText: UIViewRepresentable {
    let htmlContent: String
    @Binding var size: CGSize
    
    private let webView = WKWebView()
    var sizeObserver: NSKeyValueObservation?
    
    func makeUIView(context: Context) -> WKWebView {
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: HTMLFormattedText
        var sizeObserver: NSKeyValueObservation?
        
        init(parent: HTMLFormattedText) {
            self.parent = parent
            sizeObserver = parent.webView.scrollView.observe(
                \.contentSize,
                 options: [.new],
                 changeHandler: { (object, change) in
                     parent.size = change.newValue ?? .zero
                 }
            )
        }
    }
}
