//
//  AppInfo.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import Foundation

struct AppInfo: Codable, Hashable {
    var screenshotUrls: [String]
    var description: String
    var trackCensoredName: String
    var averageUserRating: Double
    var genres: [String]
    var artworkUrl512: String
    var userRatingCount: Int
    var contentAdvisoryRating: String
}
