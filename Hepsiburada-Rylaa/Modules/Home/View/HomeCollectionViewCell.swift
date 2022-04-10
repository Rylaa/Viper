//
//  HomeCollectionViewCell.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//


import UIKit
import SDWebImage

final class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var amount: UILabel!
    var selectedItem: ((SearchedItemDetailProtocol) -> ())?
    
    var data: SearchedItemDetailProtocol! {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        title.text = ""
        subTitle.text = ""
        amount.text = ""
        imageView.image = nil
    }
    
    @IBAction private func cellClicked(_ sender: Any) {
        selectedItem?(data)
    }
    
    func config(_ data: SearchedItemDetailProtocol) {
        self.data = data
    }
    
    private func setupView() {
        title.text = data.uiCollectionName
        subTitle.text = data.date
        amount.text = data.uiCollectionPrice.currencyFormat ?? ""
        if let url = URL(string: data.uiArtworkUrl100) {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
}

extension HomeCollectionViewCell {
    static var nib: UINib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    static var identifier: String {
        return String(describing: self)
    }
}
