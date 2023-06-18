//
//  HomeView.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            HomeHeaderView(isNeedToReload: $viewModel.isNeedToReload) //HomeHeaderview가 초기화될 때 homeViewModel의 isNeedToReload 를 주입
            MenuSuggestionSectionView(coffeeMenu: $viewModel.coffeeMenu)
            Spacer(minLength: 32.0)
            EventsSectionView(events: $viewModel.events)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
