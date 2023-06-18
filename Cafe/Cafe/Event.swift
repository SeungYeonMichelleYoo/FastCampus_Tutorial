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

}
