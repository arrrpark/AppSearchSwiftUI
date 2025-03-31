//
//  AppCell.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI

struct AppCell: View {
    
    let appInfo: AppInfo
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "")
                    .frame(width: 60, height: 60)
                    .background(.yellow)
                VStack(alignment: .leading) {
                    Text(appInfo.trackCensoredName)
                        .font(.system(size: 15))
                        .bold()
                    Text("")
                    Text(appInfo.genres.genresString)
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                }
                .frame(height: 60)
                Spacer()
                Button(action: { }) {
                    Text("Download")
                        .font(.system(size: 15) )
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(15)
                }
            }
            HStack {
                Image(systemName: "")
                    .frame(width: 200, height:300)
                    .background(.orange)
                Image(systemName: "")
                    .frame(width: 200, height:300)
                    .background(.orange)
            }
        }
    }
}

//#Preview {
//    AppCell(appInfo: AppIn)
//}

