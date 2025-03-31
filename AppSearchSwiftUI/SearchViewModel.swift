//
//  SearchViewModel.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchWord: String = ""
    @Published var appInfo: [AppInfo] = []
    @Published var path = NavigationPath()
    
    func goToDetail() {
        path.append(Route.detail)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    @MainActor
    func searchApps() async throws {
        guard !searchWord.isEmpty else {
            return
        }
        
        let parameters: [String: Any] = ["country": "us",
                                         "term": searchWord,
                                         "limit": 10,
                                         "entity": "software"]
        
        let searchResult: SearchResult = try await NetworkWrapper.shared.byGet(url: "search", params: parameters)
        
        appInfo = searchResult.results
    }
    
}
