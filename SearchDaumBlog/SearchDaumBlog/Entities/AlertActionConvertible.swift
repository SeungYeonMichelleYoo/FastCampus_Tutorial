//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by SeungYeon Yoo on 2023/02/05.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
