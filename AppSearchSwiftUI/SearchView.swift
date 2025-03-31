//
//  ContentView.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI
import SwiftData

struct SearchView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    
    @State var searchWord: String = ""
    @StateObject var searchViewModel: SearchViewModel
    
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
                        .onSubmit {
                            Task {
                                try? await searchViewModel.searchApps()
                            }
                        }
                }
                .background(Color(UIColor.systemGray5))
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
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
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let appInfo):
                    DetailView(appInfo: appInfo)
                case .home:
                    SearchView(searchViewModel)
                }
            }
        }
    }
}

#Preview {
    SearchView(SearchViewModel())
        .modelContainer(for: Item.self, inMemory: true)
}
