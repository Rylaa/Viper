//
//  HomeProtocols.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

protocol HomeViewToPresenterConformable: AnyObject {
    var view: HomePresenterToViewConformable? { get set }
    var router: HomePresenterToRouterConformable { get set }
    var interactor: HomePresenterToInteractorConformable { get set }
    var containerList: [SearchedItemContainerResultable] { get }
    var segmentedFilterType: SegmentedIndexType { get }
    func initialize()
    func reset()
    func search(with keyword: String, type: SegmentedIndexType)
    func fetchItems(type: SegmentedIndexType)
    func loadMore()
    func showDetail(_ item: SearchedItemDetailProtocol)
}

protocol HomePresenterToViewConformable: AnyObject {
    func startLoadingIndicator()
    func stopLoadingIndicator()
    func fetchingCompleted()
    func fetchingFailed(error: Error?)
}

protocol HomePresenterToInteractorConformable: AnyObject {
    var presenter: HomeInteractorToPresenterConformable? { get set }
    var worker: HomeWorkerConformable { get set }
    var workItem: DispatchWorkItem? { get set }
    var containerList: [SearchedItemContainerResultable] { get set }
    var inputLimit: Int { get }
    var segmentedFilterType: SegmentedIndexType { get set }
    var searchedText: String { get set }
    func initialize()
    func reset()
    func fetchItems(type: SegmentedIndexType)
    func search(with keyword: String, type: SegmentedIndexType)
    func fillResultable(with response: SearchResponseModel)
    func fillContainer()
    func loadMore()
    func getCurrentSectionPageCount() -> Int
}

protocol HomeInteractorToPresenterConformable: AnyObject {
    func fetchingCompleted()
    func fetchingFailed(error: Error?)
}

protocol HomePresenterToRouterConformable: AnyObject {
    func showDetail(_ item: SearchedItemDetailProtocol)
}

protocol HomeWorkerConformable {
    typealias CompletionHandler = ((Result<SearchResponseModel>) -> Void)
    func search(searchedText: String, page: Int, type: String, completion: @escaping (Result<SearchResponseModel>) -> Void)
}

protocol SearchedItemContainerResultable {
    var type: SegmentedStringType { get }
    var data: [SearchedItemDetailProtocol] { get set }
    var page: Int { get set }
    var responseCount: Int { get set }
    var isLastPageReached: Bool { get set }
}

struct SearchedItemContainer: SearchedItemContainerResultable {
    var type: SegmentedStringType
    var data: [SearchedItemDetailProtocol]
    var page: Int = 1
    var responseCount: Int = 0
    var isLastPageReached: Bool = false
    
    init(of type: SegmentedStringType, data: [SearchedItemDetailProtocol]) {
        self.type = type
        self.data = data
    }
}

protocol SearchedItemDetailProtocol {
    var uiWrapperType: WrapperType? { get  }
    var uiArtworkUrl100: String { get }
    var uiCollectionPrice: CustomAmount { get }
    var uiCollectionName: String { get }
    var uiKind: Kind? { get }
    var date: String { get }
    var uiShortDescription: String { get }
}

enum Kind: String, Codable {
    case featureMovie = "feature-movie"
    case song
    case book
    case album
    case coachedAudio = "coached-audio"
    case interactiveBooklet = "interactive- booklet"
    case musicVideo = "music-video"
    case pdfPodcast = "pdf podcast"
    case podcastEpisode = "podcast-episode"
    case software = "software-package"
    case tv = "tv- episode"
    case artistFor
}

enum WrapperType: String, Codable {
    case track
    case collection
    case artistFor
    case audiobook
    case movie
    case podcast
    case music
    case musicVideo
    case shortFilm
    case software
    case tvShow
    case all
}

enum SegmentedStringType: String {
    case movie
    case musicVideo
    case ebook
    case podcast
}

public enum SegmentedIndexType: Int {
    case movies
    case music
    case book
    case podcast
    
    func getStringType() -> SegmentedStringType {
        switch self {
        case .movies:
            return SegmentedStringType.movie
        case .music:
            return SegmentedStringType.musicVideo
        case .book:
            return SegmentedStringType.ebook
        case .podcast:
            return SegmentedStringType.podcast
        }
    }
}
