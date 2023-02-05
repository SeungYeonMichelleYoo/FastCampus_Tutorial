//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by SeungYeon Yoo on 2023/02/05.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit

//두가지 Observable 필요: 1) 서치바로 들어오는거 탐지, 2) 검색버튼 or 키보드이벤트 누르는거 탐지

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    //SearchBar 버튼 탭 이벤트
    //Relay: subject를 써도 되긴 하지만, 에러 이벤트 받지 않고 UI에 특화된건 Relay (onNext만 받음). 버튼탭은 UI이벤트라서 relay를 많이 사용.
    //PublishRelay: PublishSubject 를 래핑.
    let searchButtonTapped = PublishRelay<Void>()
    
    //SearchBar 외부로 내보낼 이벤트(MainVC와 연결)
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() { //아래 두가지 중 하나가 실행될 때 (merge로 이벤트 합치기)
        //1) 자체 search bar search button tapped (키보드가 올라와서 검색 누르는거)
        //2) search button (커스텀으로 만든 검색 버튼 클릭시)
        
        Observable
            .merge( //asObservable : Observable 형태로 변환
                self.rx.searchButtonClicked.asObservable(), //1)
                searchButton.rx.tap.asObservable() //2)
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal() //Signal로 바꿔
            .emit(to: self.rx.endEditing) //endEditing(SearchBar가 갖는 Delegate와 연결): 아래 extension으로 커스텀
            .disposed(by: disposeBag)
        
        self.shouldLoadResult = searchButtonTapped //검색 버튼이 트리거가 되어서
            .withLatestFrom(self.rx.text) { $1 ?? "" } //최근에 텍스트필드에 들어간 텍스트를 전달
            .filter { !$0.isEmpty } //빈 값 보내지 않도록 필터
            .distinctUntilChanged() //동일한 조건을 계속해서 검색해서 불필요한 네트워크 처리가 발생하지 않도록
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in //여기서 base는 결국 searchBar를 의미
            base.endEditing(true)
        }
    }
}
