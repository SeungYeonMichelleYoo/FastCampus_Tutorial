//
//  CenterAPIResponse.swift
//  FindCoronaCenter
//
//  Created by SeungYeon Yoo on 2023/05/29.
//

import Foundation

struct CenterAPIResponse: Decodable {
    let data: [Center]
}
