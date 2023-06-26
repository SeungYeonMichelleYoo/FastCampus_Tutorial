//
//  Bookmark.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/06/25.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}
