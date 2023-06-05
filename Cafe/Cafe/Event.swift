//
//  Event.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    
    let image: Image
    let title: String
    let description: String
    
    static let sample: [Event] = [
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 음료가 출시되었습니다! 꼭 드셔보세요"),
        Event(image: Image("coffee"), title: "여름 한정 메뉴", description: "여름이니깐 아이스커피 ~~ 여름이니까 더더욱 아이스커피")
    ]
}
