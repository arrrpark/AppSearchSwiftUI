//
//  DetailView.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//  

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    let appInfo: AppInfo
    
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    KFImage(URL(string: appInfo.artworkUrl512))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(appInfo.trackCensoredName)
                        Text(appInfo.genres.joined(separator: ", "))
                            .foregroundStyle(.gray)
                        Button(action: { }) {
                            Text("Download")
                                .foregroundStyle(.white)
                                .bold()
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .clipped()
                                .background(Color(UIColor.systemBlue))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(appInfo.screenshotUrls, id: \.self) { url in
                            if let url = URL(string: url) {
                                ScreenshotImageView(url: url, baseWidth: 300)
                            }
                            
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.top, 10)
                Spacer()
                Text(appInfo.description)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }
}

#Preview {
    DetailView(appInfo: mockAppInfo)
}
