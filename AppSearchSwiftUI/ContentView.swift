//
//  ContentView.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    
    @State var searchWord: String = ""
    var data = ["1","2","3","4","5","6","7"]
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                    .padding(5)
                TextField("Games, apps, stories and more", text: $searchWord)
            }
            .background(Color(UIColor.systemGray5))
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { _ in
                        AppCell()
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 20)
            Text("")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
