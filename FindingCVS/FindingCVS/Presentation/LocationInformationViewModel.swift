//
//  LocationInformationViewModel.swift
//  FindingCVS
//
//  Created by SeungYeon Yoo on 2023/04/09.
//

import RxSwift
import RxCocoa

struct LocationInformationViewModel {
    let disposeBag = DisposeBag()
    
    //viewModel -> view
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    
    //view -> viewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    
    init() {
        //MARK: - 지도 중심점 설정
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                currentLocation.take(1), //현재 위치를 최초로 한번 받았을 때
                moveToCurrentLocation
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
    }
}
