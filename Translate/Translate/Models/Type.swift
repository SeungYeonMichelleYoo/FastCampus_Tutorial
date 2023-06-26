//
//  Type.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/06/25.
//
import UIKit

//MARK: - 버튼 source(번역 전), target(번역되는 언어)
enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}
