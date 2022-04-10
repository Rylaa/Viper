

//
//  HomeViewControllerCollectionViewDataSource.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

final class HomeViewControllerCollectionViewDataSource: NSObject {
    
    private var indicatortag: Int = -321
    var presenter: HomeViewToPresenterConformable
   
    init(with presenter: HomeViewToPresenterConformable) {
        self.presenter = presenter
    }
    
    private func makeCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = presenter.containerList[presenter.segmentedFilterType.rawValue].data[indexPath.row]
        cell.config(model)
        cell.selectedItem = { [unowned self] item in
            presenter.showDetail(item)
        }
        return cell
    }
}

extension HomeViewControllerCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.containerList[presenter.segmentedFilterType.rawValue].data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return makeCell(collectionView, cellForRowAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            let loading = UIActivityIndicatorView()
            loading.style =
            UIActivityIndicatorView.Style.white
            loading.translatesAutoresizingMaskIntoConstraints = false
            loading.tintColor = UIColor.white
            loading.tag = indicatortag
            view.addSubview(loading)
            view.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
            
            
            return view
        }
        return UICollectionReusableView()
    }
}

extension HomeViewControllerCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: Int = 8
        let itemWidth = (Int(UIScreen.screenWidth)/2)-padding
        let height = itemWidth + 50
        return CGSize(width: itemWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 60.0, height: 30.0)
    }
    
}

extension HomeViewControllerCollectionViewDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            
            if let loadingView = view.viewWithTag(indicatortag) as? UIActivityIndicatorView {
                loadingView.startAnimating()
                if presenter.containerList[presenter.segmentedFilterType.rawValue].data.count > 0 && !presenter.containerList[presenter.segmentedFilterType.rawValue].isLastPageReached {
                    loadingView.startAnimating()
                    presenter.loadMore()
                } else {
                    loadingView.stopAnimating()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            if let loadingView = view.viewWithTag(indicatortag) as? UIActivityIndicatorView {
                loadingView.stopAnimating()
                loadingView.removeFromSuperview()
            }
        }
    }
}
