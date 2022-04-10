//
//  DetailViewController.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan on 1.04.2022.
//

import UIKit

class DetailViewController: BaseVC {
    
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descLbl: UILabel!
    @IBOutlet private weak var dateLbl: UILabel!
    @IBOutlet private weak var dateContainerView: UIView!
    @IBOutlet private weak var imageDetail: UIImageView!
    var presenter: DetailViewToPresenterConformable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.initialize()
        dateContainerView.layer.cornerRadius = 16
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    @IBAction private func playPressed(_ sender: Any) {}
}

extension DetailViewController: DetailPresenterToViewConformable {
    func setupView(detailItem: SearchedItemDetailProtocol) {
        titleLbl.text = detailItem.uiCollectionName
        dateLbl.text = detailItem.date
        descLbl.text = detailItem.uiShortDescription
        if let url = URL(string: detailItem.uiArtworkUrl100) {
            imageDetail.sd_setImage(with: url, completed: nil)
        }
    }
}



extension DetailViewController: StoryboardInstantiable {
    static var storyboardName: String { return "Detail" }
    static var storyboardIdentifier: String? { return "DetailViewController" }
}

