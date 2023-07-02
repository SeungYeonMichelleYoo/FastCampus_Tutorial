//
//  Language.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/06/20.
//

import Foundation

enum Language: String, CaseIterable, Codable {
    case ko
    case en
    case ja
    case ch = "zn-CN"
    
    var title: String {
        switch self {
        case .ko: return "한국어"
        case .en: return "영어"
        case .ja: return "일본어"
        case .ch: return "중국어"
        }
    }
    
    var languageCode: String {
        self.rawValue
    }
}
