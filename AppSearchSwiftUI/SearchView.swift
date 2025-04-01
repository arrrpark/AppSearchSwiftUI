//
//  ContentView.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var searchViewModel: SearchViewModel
    @FocusState private var searchFocused: Bool
    
    init(_ searchViewModel: SearchViewModel) {
        _searchViewModel = StateObject(wrappedValue: searchViewModel)
    }
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationStack(path: $searchViewModel.path) {
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                        .padding(5)
                    TextField("Games, apps, stories and more", text: $searchViewModel.searchWord)
                        .focused($searchFocused)
                        .onSubmit {
                            Task {
                                try? await searchViewModel.searchApps(searchViewModel.searchWord)
                                let newItem = Word(word: searchViewModel.searchWord, timestamp: .now)
                                searchViewModel.insertWord(newItem)
                                print(searchViewModel.words)
                            }
                        }
                }
                .background(Color(UIColor.systemGray5))
                .padding(.horizontal, 20)
                .padding(.top, 10)
                if searchFocused && !searchViewModel.words.isEmpty {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(searchViewModel.words.sorted { $0.timestamp > $1.timestamp }) { word in
                                RecentWordCell(word: word.word)
                                    .onTapGesture {
                                        Task {
                                            try? await searchViewModel.searchApps(word.word)
                                            searchFocused = false
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<searchViewModel.appInfo.count, id: \.self) { index in
                                let appInfo = searchViewModel.appInfo[index]
                                AppCell(appInfo: appInfo)
                                    .onTapGesture {
                                        searchViewModel.goToDetail(appInfo)
                                    }
                                
                                if index == searchViewModel.appInfo.count - 1 {
                                    Color.clear
                                        .frame(height: 1)
                                        .onAppear {
                                            Task {
                                                print("last touched")
                                                try? await searchViewModel.fetchMore()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, 20)
                    Color.clear.frame(height: 1)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let appInfo):
                    DetailView(appInfo: appInfo)
                case .home:
                    SearchView(searchViewModel)
                }
            }
        }
        .onAppear {
            searchViewModel.setWordDAO(modelContext)
            searchViewModel.fetchWords()
            print(searchViewModel.words)
        }
    }
}

#Preview {
    SearchView(SearchViewModel())
        .modelContainer(for: Word.self, inMemory: true)
}
