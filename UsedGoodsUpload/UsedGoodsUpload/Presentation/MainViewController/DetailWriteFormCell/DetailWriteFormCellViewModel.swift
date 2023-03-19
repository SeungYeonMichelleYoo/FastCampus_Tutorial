//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by SeungYeon Yoo on 2023/03/19.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    //View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
