//
//  DetailPresenter.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan on 1.04.2022.
//

import Foundation

final class DetailPresenter: DetailViewToPresenterConformable {
    
    weak var view: DetailPresenterToViewConformable?
    var router: DetailPresenterToRouterConformable
    var detailItem: SearchedItemDetailProtocol { interactor.detailItem }
    var interactor: DetailPresenterToInteractorConformable
    
    init(interactor: DetailPresenterToInteractorConformable, router: DetailPresenterToRouterConformable) {
        self.interactor = interactor
        self.router = router
    }

    func initialize() {
        interactor.initialize()
    }
    
}

extension DetailPresenter: DetailInteractorToPresenterConformable {
    func fetchingCompleted() {
        view?.setupView(detailItem: detailItem)
    }
}
