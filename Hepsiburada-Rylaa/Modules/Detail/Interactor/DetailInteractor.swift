//
//  DetailInteractor.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan on 1.04.2022.
//

import Foundation

final class DetailInteractor: DetailPresenterToInteractorConformable {
   
    weak var presenter: DetailInteractorToPresenterConformable?
    var worker: DetailWorkerConformable  = Api.shared
    var detailItem: SearchedItemDetailProtocol
    
    init(detailItem: SearchedItemDetailProtocol) {
        self.detailItem = detailItem
    }

    func initialize() {
        presenter?.fetchingCompleted()
    }
}

