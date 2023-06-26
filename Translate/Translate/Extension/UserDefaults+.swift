//
//  UserDefaults+.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/06/25.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case bookmarks
    }
    
    var bookmarks: [Bookmark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.rawValue) else {
                return [] }
            
            return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey: Key.bookmarks.rawValue)
        }
    }
}

//UserDefaults를 extension으로 사용하는 이유? var a: String { UserDefaults.standard.data(forKey: "key") } 이런식으로 쓰게 되면 key 값에 휴먼 에러 오타 발생 가능성 있기 때문.
