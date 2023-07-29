//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by SeungYeon Yoo on 2023/07/29.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
}

final class ReviewWritePresenter {
    private let viewController: ReviewWriteProtocol
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
}
