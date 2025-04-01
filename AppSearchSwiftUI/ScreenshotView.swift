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
    let baseWidth: CGFloat
    @State var imageSize: CGSize
    @State var image: Image?
    
    init(url: URL, baseWidth: CGFloat) {
        self.url = url
        self.baseWidth = baseWidth
        self.imageSize = CGSize(width: baseWidth, height: baseWidth * 1.75)
    }
    
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
                guard let loadedImage = try? await KingfisherManager.shared.retrieveImage(with: url) else {
                    return
                }
                
                let size = loadedImage.image.size
                let ratio = size.height / size.width

                var imageWidth: CGFloat = 0
                var imageHeight: CGFloat = 0
                
                imageWidth = baseWidth
                imageHeight = baseWidth * ratio
                
                if ratio < 1 {
                    imageWidth *= 1.5
                    imageHeight *= 1.5
                }
                
                imageSize = CGSize(width: imageWidth, height: imageHeight)
                image = Image(uiImage: loadedImage.image)
            }
        }
    }
}

