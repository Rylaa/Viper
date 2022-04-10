//
//  HomeRouter.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

class HomeRouter: HomePresenterToRouterConformable {
 
    var navigationController: UINavigationController?
    weak var viewController: UIViewController?

    func showDetail(_ item: SearchedItemDetailProtocol) {
       let viewControlller = DetailRouter.createModule(using: navigationController, with: item)
        navigationController?.pushViewController(viewControlller, animated: true)
    }
}

extension HomeRouter {
    static func createModule(using navigationController: UINavigationController?) -> HomeViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let view = HomeViewController.initializeFromStoryboard()
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.navigationController = navigationController
        router.viewController = view

        return view
    }
}

