//
//  DetailProtocols.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

protocol DetailViewToPresenterConformable: AnyObject {
    var view: DetailPresenterToViewConformable? { get set }
    var router: DetailPresenterToRouterConformable { get set }
    var detailItem: SearchedItemDetailProtocol { get }
    func initialize()
}

protocol DetailPresenterToViewConformable: AnyObject {
   func setupView(detailItem: SearchedItemDetailProtocol)
}

protocol DetailPresenterToInteractorConformable: AnyObject {
    var presenter: DetailInteractorToPresenterConformable? { get set }
    var worker: DetailWorkerConformable { get set }
    var detailItem: SearchedItemDetailProtocol { get set }
    func initialize()
}

protocol DetailInteractorToPresenterConformable: AnyObject {
    func fetchingCompleted() 
}
protocol DetailPresenterToRouterConformable: AnyObject {}
protocol DetailWorkerConformable {}
