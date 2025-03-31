//
//  AppCell.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI
import Kingfisher

struct AppCell: View {
    
    let appInfo: AppInfo
    
    @State private var imageSize: CGSize = .zero
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: appInfo.artworkUrl512))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(appInfo.trackCensoredName)
                        .font(.system(size: 15))
                        .bold()
                    Text("")
                    Text(appInfo.genres.joined(separator: ", "))
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                }
                .frame(height: 60)
                Spacer()
                Button(action: { }) {
                    Text("Download")
                        .font(.system(size: 15) )
                        .bold()
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(15)
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(appInfo.screenshotUrls, id: \.self) { url in
                        if let url = URL(string: url) {
                            ScreenshotImageView(url: url, baseWidth: 140)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

extension Image {
    var uiImage: UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        return renderer.image { _ in }.cgImage.flatMap { UIImage(cgImage: $0) }
    }
}

let mockAppInfo = AppInfo(screenshotUrls: ["https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/90/e2/4b/90e24bd5-b81b-558a-3b1a-e5acf46a7669/bace9abd-71f3-4700-8adf-cedcba275a67_iOS-5.5-in_5.jpg/392x696bb.jpg", "b", "c", "d"],
                          description: "",
                          trackCensoredName: "",
                          averageUserRating: 3.5,
                          genres: ["video, entertainment"],
                          artworkUrl512: "",
                          userRatingCount: 50,
                          contentAdvisoryRating: "")

#Preview {
    AppCell(appInfo: mockAppInfo)
}

