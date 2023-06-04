//
//  SelectRegionViewModel.swift
//  FindCoronaCenter
//
//  Created by SeungYeon Yoo on 2023/06/04.
//

import Foundation
import Combine

class SelectRegionViewModel: ObservableObject { //ObservableObject? 외부에서 바라볼 수 있는 object. View와 연결할 때 사용
    @Published var centers = [Center.Sido: [Center]]() //@Published: 어떤 객체를 내보낼지 표현
    private var cancellables = Set<AnyCancellable>() //Rx의 disposeBag에 해당
    
    init(centerNetwork: CenterNetwork = CenterNetwork()) {
        centerNetwork.getCenterList()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] in
                    guard case .failure(let error) = $0 else { return }
                    print(error.localizedDescription)
                    self?.centers = [Center.Sido: [Center]]()
                },
                receiveValue: {[weak self] centers in
                    self?.centers = Dictionary(grouping: centers) { $0.sido }
                }
            )
            .store(in: &cancellables) //disposed(by:disposeBag)
    }
}
