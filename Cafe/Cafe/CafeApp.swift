//
//  CafeApp.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import SwiftUI

@main
struct CafeApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .accentColor(.green)
        }
    }
}

//tintColor (UIKit)
//accentColor (SwiftUI)
