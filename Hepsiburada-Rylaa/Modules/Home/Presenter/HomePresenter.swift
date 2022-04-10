//
//  HomePresenter.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

final class HomePresenter: HomeViewToPresenterConformable {
   
    weak var view: HomePresenterToViewConformable?
    var router: HomePresenterToRouterConformable
    var interactor: HomePresenterToInteractorConformable
    var containerList: [SearchedItemContainerResultable] { interactor.containerList }
    var segmentedFilterType: SegmentedIndexType { interactor.segmentedFilterType }
    
    init(interactor: HomePresenterToInteractorConformable, router: HomePresenterToRouterConformable) {
        self.interactor = interactor
        self.router = router
    }

    func initialize() {
        interactor.initialize()
    }
    
    func search(with keyword: String, type: SegmentedIndexType) {
        view?.startLoadingIndicator()
        interactor.search(with: keyword, type: type)
    }

    func fetchItems(type: SegmentedIndexType) {
        view?.startLoadingIndicator()
        interactor.fetchItems(type: type)
    }
       
    func loadMore() {
        interactor.loadMore()
    }
    
    func reset() {
        interactor.reset()
    }
    
    func showDetail(_ item: SearchedItemDetailProtocol) {
        router.showDetail(item)
    }
}

extension HomePresenter: HomeInteractorToPresenterConformable {
    func fetchingCompleted() {
        view?.stopLoadingIndicator()
        view?.fetchingCompleted()
    }

    func fetchingFailed(error: Error?) {
        view?.stopLoadingIndicator()
        view?.fetchingFailed(error: error)
    }
}
