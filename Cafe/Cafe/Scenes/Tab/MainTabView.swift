//
//  MainTabView.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Tab.home.imageItem
                    Tab.home.textItem
                }
            Text("Other")
                .tabItem {
                    Tab.other.imageItem
                    Tab.other.textItem
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//struct SampleListView: View {
//
//    struct Number: Identifiable {
//        let value: Int
//        var id: Int { value }
//    }
//
//    let numbers: [Number] = (0...100).map { Number(value: $0) }
//
//    var body: some View {
//        List {
//            Section(header: Text("Header")) {
//                ForEach(numbers) { number in
//                    Text("\(number.value)")
//                }
//            }
//            Section(header: Text("Second Header"), footer: Text("Footer")) {
//                ForEach(numbers) { number in
//                    Text("\(number.value)")
//                }
//            }
//        }
//    }
//}
//
//struct SampleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleListView()
//    }
//}
