//
//  Untitled.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

class NetworkWrapper {
    enum NetworkError: Error {
        case badForm
        case invalidResponse
    }
    
    static let shared = NetworkWrapper()
    
    private init() { }
    
    private let baseURL = "https://itunes.apple.com/"
    private let headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    private var session: URLSessionProtocol = URLSession.shared
    
    static func configureForTesting(session: URLSessionProtocol) {
        shared.session = session
    }
    
    func byGet<T: Codable>(url: String, params: [String: Any]? = nil) async throws -> T {
        let concatenatedURL = concatenateGetURL(url: url, params: params)
        let url = URL(string: concatenatedURL)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.badForm
        }
    }
    
    func concatenateGetURL(url: String, params: [String: Any]? = nil) -> String {
        var queryString = ""
        if let params {
            queryString = params.keys
                .sorted { $0 < $1 }
                .map { "\($0)=\(params[$0]!)" }
                .joined(separator: "&")
        }
        let str = "\(baseURL)/\(url)?\(queryString)"
        return str
    }
}
