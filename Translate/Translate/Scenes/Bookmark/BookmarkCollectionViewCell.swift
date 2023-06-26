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
    
    private var sourceBookmarkTextStackView = BookmarkTextStackView(language: .ko, text: "안녕하세요", type: .source)
    private var targetBookmarkTextStackView = BookmarkTextStackView(language: .en, text: "hello", type: .target)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        [sourceBookmarkTextStackView, targetBookmarkTextStackView]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    func setup() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
    }
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        [contentLabel].forEach {
            contentView.addSubview($0)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalToSuperview().multipliedBy(0.35)
            make.width.equalTo(227)
            make.height.equalTo(76)
        }
    }
}
