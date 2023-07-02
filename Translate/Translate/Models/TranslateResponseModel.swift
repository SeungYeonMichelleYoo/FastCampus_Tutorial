//
//  TranslateResponseModel.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/07/02.
//

import Foundation

struct TranslateResponseModel: Decodable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText } //실질적으로 필요한 변수를 편하게 꺼내쓸 수 있도록 따로 정의해둠. 이렇게 안하면 매번 message.result.translatedText 적어야되어서.
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
}
