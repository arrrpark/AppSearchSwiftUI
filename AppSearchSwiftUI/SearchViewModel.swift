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
    
    var offset = 0
    var lastWord = ""
    var lastReached = false
    var isFetching = false
    
    func goToDetail(_ appInfo: AppInfo) {
        path.append(Route.detail(appInfo))
    }
    
    func goBack() {
        path.removeLast()
    }
    
    @MainActor
    func searchApps() async throws {
        guard !searchWord.isEmpty,
              !isFetching else {
            return
        }
        
        offset = 0
        lastReached = false
        isFetching = true
        let parameters: [String: Any] = ["country": "us",
                                         "term": searchWord,
                                         "limit": 10,
                                         "entity": "software"]
        
        lastWord = searchWord
        let searchResult: SearchResult = try await NetworkWrapper.shared.byGet(url: "search", params: parameters)
        appInfo = searchResult.results
        offset = appInfo.count
        isFetching = false
        
        print("first : \(appInfo.count)")
    }
    
    @MainActor
    func fetchMore() async throws {
        guard !lastWord.isEmpty,
              !lastReached,
              !isFetching else {
            return
        }
        
        isFetching = true
        let parameters: [String: Any] = ["country": "us",
                                         "term": lastWord,
                                         "limit": 10,
                                         "entity": "software",
                                         "offset": offset]
        
        let searchResult: SearchResult = try await NetworkWrapper.shared.byGet(url: "search", params: parameters)
        appInfo.append(contentsOf: searchResult.results)
        offset = appInfo.count
        isFetching = false
        
        print("new fetched : \(searchResult.results.count)")
        print("total : \(appInfo.count)")
    }
}
