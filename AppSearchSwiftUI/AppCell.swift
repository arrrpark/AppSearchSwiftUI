//
//  AppCell.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftUI

struct AppCell: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "")
                    .frame(width: 60, height: 60)
                    .background(.yellow)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Moe Can Change")
                        .font(.system(size: 15))
                        .bold()
                    Text("Games, simulation Games, simulation")
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                }
                .frame(width: .infinity, height: 60)
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

#Preview {
    AppCell()
}

