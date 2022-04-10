//
//  HomeInteractor.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

final class HomeInteractor: HomePresenterToInteractorConformable {
    
    weak var presenter: HomeInteractorToPresenterConformable?
    var worker: HomeWorkerConformable = Api.shared
    var workItem: DispatchWorkItem?
    var inputLimit: Int { 2 }
    var containerList: [SearchedItemContainerResultable] = []
    var searchedText: String = ""
    var segmentedFilterType: SegmentedIndexType = .movies
    
    init() {}
    
    func initialize() {
        fillContainer()
    }
    
    func loadMore() {
        if let index = containerList.firstIndex(where: { $0.type == segmentedFilterType.getStringType() }) {
            if containerList[index].isLastPageReached {
                return
            }
            containerList[index].page+=1
        }
        fetchItems(type: segmentedFilterType)
    }
    
    func search(with keyword: String, type: SegmentedIndexType) {
        guard !keyword.isEmpty && keyword.count > inputLimit else { return }
        searchedText = keyword
        fillContainer()
        fetchItems(type: type)
    }
    
    func fetchItems(type: SegmentedIndexType) {
        segmentedFilterType = type
        workItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [unowned self] in
            worker.search(searchedText: searchedText,
                          page: getCurrentSectionPageCount(),
                          type: segmentedFilterType.getStringType().rawValue) { [unowned self] result in
                switch result {
                case .success(let data):
                    fillResultable(with: data)
                case .failure(let error):
                    presenter?.fetchingFailed(error: error)
                }
            }
        }
        
        workItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: requestWorkItem)
    }
    
    func fillResultable(with response: SearchResponseModel) {
        if let index = containerList.firstIndex(where: { $0.type == segmentedFilterType.getStringType() }),
           let list = response.results,
           let count = response.resultCount {
            containerList[index].data.append(contentsOf: list)
            containerList[index].isLastPageReached = containerList[index].responseCount == count
            containerList[index].responseCount = count
        }
        presenter?.fetchingCompleted()
    }
    
    func fillContainer() {
        let movieContainer = SearchedItemContainer(of: .movie, data: [])
        let musicContainer = SearchedItemContainer(of: .musicVideo, data: [])
        let bookContainer = SearchedItemContainer(of: .ebook, data: [])
        let podcastContainer = SearchedItemContainer(of: .podcast, data: [])
        containerList = [movieContainer, musicContainer, bookContainer, podcastContainer]
    }
    
    func reset() {
        searchedText = ""
        fillContainer()
        presenter?.fetchingCompleted()
    }
    
    func getCurrentSectionPageCount() -> Int {
        if let index = containerList.firstIndex(where: { $0.type == segmentedFilterType.getStringType() }) {
            return containerList[index].page
        }
        return 1
    }
}
