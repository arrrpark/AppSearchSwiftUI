//
//  DetailView.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    var body: some View {
        Button("back") {
            searchViewModel.goBack()
        }
    }
}
