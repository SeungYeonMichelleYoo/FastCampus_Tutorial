//
//  HomeViewModel.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/11.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isNeedToReload = false {
        didSet {
            guard isNeedToReload else { return }
            
            coffeeMenu.shuffle()
            events.shuffle()
            
            isNeedToReload = false
        }
    }
    
    @Published var coffeeMenu: [CoffeeMenu] = [
        CoffeeMenu(image: Image("coffee"), name: "아메리카노"),
        CoffeeMenu(image: Image("coffee"), name: "라떼"),
        CoffeeMenu(image: Image("coffee"), name: "카푸치노"),
        CoffeeMenu(image: Image("coffee"), name: "드립커피"),
        CoffeeMenu(image: Image("coffee"), name: "에스프레소"),
        CoffeeMenu(image: Image("coffee"), name: "모카라떼"),
        CoffeeMenu(image: Image("coffee"), name: "바닐라라떼")
    ]
    
    @Published var events: [Event] = [
        Event(image: Image("coffee"), title: "제주도 한정 메뉴", description: "제주도 한정 음료가 출시되었습니다! 꼭 드셔보세요"),
        Event(image: Image("coffee"), title: "여름 한정 메뉴", description: "여름이니깐 아이스커피 ~~ 여름이니까 더더욱 아이스커피")
    ]
}
