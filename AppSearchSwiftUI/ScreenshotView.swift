//
//  ScreenshotURL.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI
import Kingfisher

struct ScreenshotImageView: View {
    
    let url: URL
    @State var image: Image?
    @State var imageSize: CGSize = CGSize(width: 140, height: 140 * 1.75)
    
    var body: some View {
        VStack {
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
            } else {
                ProgressView()
                    .frame(width: imageSize.width, height: imageSize.height)
            }
        }
        .frame(width: imageSize.width, height: imageSize.height)
        .onAppear {
            Task {
//                try? await KingfisherManager.shared.retrieveImage(with: url)
                guard let loadedImage = try? await KingfisherManager.shared.retrieveImage(with: url) else {
                    return
                }
                
//                loadedImage.image.size
//                let size = loadedImage.size
//                let ratio = size.height / size.width
//                
//                if ratio > 1 {
//                    imageSize = CGSize(width: 140, height: 140 * ratio)
//                } else {
//                    imageSize = CGSize(width: 140 * ratio, height: 140)
//                }
//
//                print(imageSize)
                image = Image(uiImage: loadedImage.image)
//                imageSize = loadedImage.size
            }
        }
    }
}

