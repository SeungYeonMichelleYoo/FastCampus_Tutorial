//
//  SourceTextViewController.swift
//  Translate
//
//  Created by SeungYeon Yoo on 2023/06/20.
//

import UIKit
import SnapKit

protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}

final class SourceTextViewController: UIViewController {
    private let placeholderText = "텍스트 입력"
    
    private weak var delegate: SourceTextViewControllerDelegate? //메모리 누수 발생할 수 있기 때문에 옵셔널로 처리. weak var -> 옵셔널 사용.
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        
        return textView
    }()
    
    init(delegate: SourceTextViewControllerDelegate?) { //위에서 쓴 delegate 값이 여기서 주입되기 때문에, 여기서 파라미터로 만들어줌
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
}

extension SourceTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) { //사용자가 무언가를 입력하려고 '텍스트입력' 메모장을 딱 탭했을 때
        guard textView.textColor == .secondaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        delegate?.didEnterText(textView.text) //dismiss하기 바로 전 타이밍에 TranslateVC로 해당 text 전달
        dismiss(animated: true)
        
        return true
    }
}
