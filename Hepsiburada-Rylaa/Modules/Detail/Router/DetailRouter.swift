//
//  DetailRouter.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

class DetailRouter: DetailPresenterToRouterConformable {
 
    var navigationController: UINavigationController?
    weak var viewController: UIViewController?
    
}

extension DetailRouter {
    static func createModule(using navigationController: UINavigationController?, with item: SearchedItemDetailProtocol) -> DetailViewController {
        let router = DetailRouter()
        let interactor = DetailInteractor(detailItem: item)
        let presenter = DetailPresenter(interactor: interactor, router: router)
        let view = DetailViewController.initializeFromStoryboard()
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.navigationController = navigationController
        router.viewController = view

        return view
    }
}

