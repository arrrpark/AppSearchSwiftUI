//
//  RecentWordCell.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI

struct RecentWordCell: View {
    
    let word: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color(UIColor.systemGray))
                Text(word)
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
                Spacer()
            }
            Color.gray.frame(height: 1)
        }
    }
}

#Preview {
    RecentWordCell(word: "Hello")
}
