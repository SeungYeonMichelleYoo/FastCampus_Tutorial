//
//  BookmarkCollectionViewCell.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/06/25.
//

import UIKit
import SnapKit

class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkTextStackView = BookmarkTextStackView(language: Language.ko, text: "", type: .source)
    private var targetBookmarkTextStackView = BookmarkTextStackView(language: Language.en, text: "", type: .target)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true //stackView가 layout margin을 기준으로 정렬된 뷰를 배치(stackview 자체의 inset 설정)
                
        return stackView
    }()
    
    func setup(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.sourceLanguage,
            text: bookmark.sourceText,
            type: .source)
        
        targetBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.translatedLanguage,
            text: bookmark.translatedText,
            type: .target)
        
        stackView.subviews.forEach { $0.removeFromSuperview() } //reuse 문제 때문에 추가한 코드
        
        [sourceBookmarkTextStackView, targetBookmarkTextStackView]
            .forEach { stackView.addArrangedSubview($0) }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }
    
        layoutIfNeeded()
    }
}
