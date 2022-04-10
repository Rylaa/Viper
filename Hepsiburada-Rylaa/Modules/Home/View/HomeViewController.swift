//
//  HomeViewController.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

struct HomeViewConstants {
    static let ok = "Tamam"
    static let error = "Hata"
    static let search = "Ara"
}

final class HomeViewController: BaseVC {
    
    @IBOutlet private weak var segmentedContainer: UIView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var indicator: UIActivityIndicatorView!
    private var dataSource: HomeViewControllerCollectionViewDataSource!
    private lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: .zero, height: 24))
    var presenter: HomeViewToPresenterConformable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.initialize()
    }
}

fileprivate extension HomeViewController {
    func setupUI() {
        collectionView.register(HomeCollectionViewCell.nib, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        dataSource = HomeViewControllerCollectionViewDataSource(with: presenter)
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        
        indicator = UIActivityIndicatorView()
        indicator.center = view.center
        view.addSubview(indicator)
        
        searchBar.delegate = self
        searchBar.placeholder = HomeViewConstants.search
        searchBar.setupSearchBar(background: .clear, inputText: .white, placeholderText: .gray, image: .gray)
        navigationItem.titleView = searchBar
        
        segmentedControl.selectedSegmentTintColor(theme.color.primary)
        segmentedControl.unselectedSegmentTintColor(.white)
        segmentedControl.addTarget(self, action: #selector(segmentedClicked), for: .valueChanged)
    }
    
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: HomeViewConstants.error, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: HomeViewConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
   @objc func segmentedClicked() {
       if let type = SegmentedIndexType(rawValue: segmentedControl.selectedSegmentIndex) {
           presenter.fetchItems(type: type)
           collectionView.reloadData()
       }
    }
}

extension HomeViewController: HomePresenterToViewConformable {
    
    func fetchingCompleted() {
        segmentedContainer.isHidden = false
        collectionView.reloadData()
    }
    
    func startLoadingIndicator() {
        indicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        indicator.stopAnimating()
    }
    
    func fetchingFailed(error: Error?) {
        if let errorStr = error?.localizedDescription {
            showMessage(errorStr)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let type = SegmentedIndexType(rawValue: segmentedControl.selectedSegmentIndex) {
            searchText.isEmpty
            ? presenter.reset()
            : presenter.search(with: searchText, type: type)
        }
    }
}

extension HomeViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main {
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController: StoryboardInstantiable {
    static var storyboardName: String { return "Home" }
    static var storyboardIdentifier: String? { return "HomeViewController" }
}
