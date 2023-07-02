//
//  TranslateRequestModel.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/07/02.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}
