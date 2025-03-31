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
                            print("done pressed")
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
                        ForEach(searchViewModel.appInfo, id: \.self) { appInfo in
                            AppCell(appInfo: appInfo)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 20)
                Text("")
            }
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .detail:
                DetailView()
            case .home:
                SearchView(searchViewModel)
            }
        }
    }
}

#Preview {
    SearchView(SearchViewModel())
        .modelContainer(for: Item.self, inMemory: true)
}
