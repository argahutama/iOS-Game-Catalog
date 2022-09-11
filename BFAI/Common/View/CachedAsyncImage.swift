//
//  CachedAsyncImage.swift
//  BFAI
//
//  Created by Arga Hutama on 11/09/22.
//

import SwiftUI

public struct CachedAsyncImage<Content>: View where Content: View {
    
    @State private var phase: AsyncImagePhase
    
    private let urlRequest: URLRequest?
    
    private let urlSession: URLSession
    
    private let scale: CGFloat
    
    private let transaction: Transaction
    
    private let content: (AsyncImagePhase) -> Content
    
    public var body: some View {
        content(phase)
            .task(id: urlRequest, load)
    }
    
    public init(url: URL?, urlCache: URLCache = .shared,  scale: CGFloat = 1) where Content == Image {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale)
    }
    
    public init(urlRequest: URLRequest?, urlCache: URLCache = .shared,  scale: CGFloat = 1) where Content == Image {
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale) { phase in
            phase.image ?? Image(uiImage: .init())
        }
    }
    
    public init<I, P>(url: URL?, urlCache: URLCache = .shared,  scale: CGFloat = 1, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale, content: content, placeholder: placeholder)
    }
    
    public init<I, P>(urlRequest: URLRequest?, urlCache: URLCache = .shared,  scale: CGFloat = 1, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View {
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale) { phase in
            if let image = phase.image {
                content(image)
            } else {
                placeholder()
            }
        }
    }
    
    public init(url: URL?, urlCache: URLCache = .shared, scale: CGFloat = 1, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale, transaction: transaction, content: content)
    }
    
    public init(urlRequest: URLRequest?, urlCache: URLCache = .shared, scale: CGFloat = 1, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        self.urlRequest = urlRequest
        self.urlSession =  URLSession(configuration: configuration)
        self.scale = scale
        self.transaction = transaction
        self.content = content
        
        self._phase = State(wrappedValue: .empty)
        do {
            if let urlRequest = urlRequest, let image = try cachedImage(from: urlRequest, cache: urlCache) {
                self._phase = State(wrappedValue: .success(image))
            }
        } catch {
            self._phase = State(wrappedValue: .failure(error))
        }
    }
    
    @Sendable
    private func load() async {
        do {
            if let urlRequest = urlRequest {
                let (image, metrics) = try await remoteImage(from: urlRequest, session: urlSession)
                if metrics.transactionMetrics.last?.resourceFetchType == .localCache {
                    // WARNING: This does not behave well when the url is changed with another
                    phase = .success(image)
                } else {
                    withAnimation(transaction.animation) {
                        phase = .success(image)
                    }
                }
            } else {
                withAnimation(transaction.animation) {
                    phase = .empty
                }
            }
        } catch {
            withAnimation(transaction.animation) {
                phase = .failure(error)
            }
        }
    }
}

private extension AsyncImage {
    struct LoadingError: Error {
    }
}

private extension CachedAsyncImage {
    private func remoteImage(from request: URLRequest, session: URLSession) async throws -> (Image, URLSessionTaskMetrics) {
        let (data, _, metrics) = try await session.data(for: request)
        if metrics.redirectCount > 0, let lastResponse = metrics.transactionMetrics.last?.response {
            let requests = metrics.transactionMetrics.map { $0.request }
            requests.forEach(session.configuration.urlCache!.removeCachedResponse)
            let lastCachedResponse = CachedURLResponse(response: lastResponse, data: data)
            session.configuration.urlCache!.storeCachedResponse(lastCachedResponse, for: request)
        }
        return (try image(from: data), metrics)
    }
    
    private func cachedImage(from request: URLRequest, cache: URLCache) throws -> Image? {
        guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }
        return try image(from: cachedResponse.data)
    }
    
    private func image(from data: Data) throws -> Image {
        if let uiImage = UIImage(data: data, scale: scale) {
            return Image(uiImage: uiImage)
        } else {
            throw AsyncImage<Content>.LoadingError()
        }
    }
}

private class URLSessionTaskController: NSObject, URLSessionTaskDelegate {
    
    var metrics: URLSessionTaskMetrics?
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        self.metrics = metrics
    }
}
 
private extension URLSession {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse, URLSessionTaskMetrics) {
        let controller = URLSessionTaskController()
        let (data, response) = try await data(for: request, delegate: controller)
        return (data, response, controller.metrics!)
    }
}
