//
//  CoffeeMenu.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import SwiftUI

struct CoffeeMenu: Identifiable {
    let image: Image
    let name: String
    
    let id = UUID()
    
    static let sample: [CoffeeMenu] = [
        CoffeeMenu(image: Image("coffee"), name: "아메리카노"),
        CoffeeMenu(image: Image("coffee"), name: "라떼"),
        CoffeeMenu(image: Image("coffee"), name: "카푸치노"),
        CoffeeMenu(image: Image("coffee"), name: "드립커피"),
        CoffeeMenu(image: Image("coffee"), name: "에스프레소"),
        CoffeeMenu(image: Image("coffee"), name: "모카라떼"),
        CoffeeMenu(image: Image("coffee"), name: "바닐라라떼")
    ]
}
