//
//  HomeHeaderView.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var isNeedToReload: Bool
    
    var body: some View {
        VStack(spacing: 16.0) {
            HStack(alignment: .top) {
                Text("""
                    \(User.shared.username)님~
                    반갑습니다! ☕️
                    """)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                Button(action: {
                    isNeedToReload = true
                }, label: {
                    Image(systemName: "arrow.2.circlepath")
                })
            }
            HStack {
                Button(action: {}) {
                    Image(systemName: "mail")
                        .foregroundColor(.secondary)
                    Text("What's New")
                        .foregroundColor(.primary)
                        .font(.system(size: 16.0, weight: .semibold, design: .default))
                }
                Button(action: {}) {
                    Image(systemName: "ticket")
                        .foregroundColor(.secondary)
                    Text("Coupon")
                        .foregroundColor(.primary)
                        .font(.system(size: 16.0, weight: .semibold, design: .default))
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "bell")
                    .foregroundColor(.secondary)
                }
            }
        }
        .padding(16.0)
        
    }
}

//struct HomeHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeHeaderView()
//    }
//}
