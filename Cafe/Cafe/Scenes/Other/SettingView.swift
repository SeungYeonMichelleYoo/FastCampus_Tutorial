//
//  SettingView.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/11.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section {
                SettingUserInfoSectionView()
            }
            Button("회원 정보 수정") { }
                .accentColor(.black)
            Button("회원 탈퇴") { }
                .accentColor(.black)
        }
            .navigationTitle("설정")
            .listStyle(GroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingUserInfoSectionView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(User.shared.username)
                    .font(.title)
                Text(User.shared.account)
                    .font(.caption)
            }
            Spacer()
            Button(action: {}) {
                Text("로그아웃")
                    .accentColor(.green)
                    .font(.system(size: 14.0, weight: .bold, design: .default))
            }
            .padding(8.0) //글자와 테두리 사이의 패딩
            .overlay(Capsule().stroke(Color.green)) //버튼 테두리 둥글게
        }
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
