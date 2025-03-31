//
//  Untitled.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import Foundation

extension Array where Element == String {
    var genresString: String {
        let genresString = NSMutableString()
        self.forEach {
            genresString.append($0)
            genresString.append(", ")
        }
        genresString.deleteCharacters(in: NSRange(location: genresString.length - 2, length: 2))
        return genresString as String
    }
}
