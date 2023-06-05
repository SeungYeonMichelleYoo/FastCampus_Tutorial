//
//  User.swift
//  Cafe
//
//  Created by SeungYeon Yoo on 2023/06/05.
//

import Foundation

struct User {
    let username: String
    let account: String
    
    static let shared = User(username: "패캠", account: "fast.campus")
}
