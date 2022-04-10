//
//  BaseVC.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar() 
        }
    
    func setupNavBar() {
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = theme.color.primary
            navigationController?.navigationBar.barTintColor = UIColor.white
            navigationController?.navigationBar.tintColor = UIColor.white
            let backImage = UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal)
            navigationController?.navigationBar.backIndicatorImage = backImage
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.backgroundColor = theme.color.primary
        }
        theme.appTheme.setCustomBackButton()
    }
    
    func backButtonWithTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let button: UIButton = UIButton(type: .custom)
            let image = UIImage(named: "backIcon")?.imageFlippedForRightToLeftLayoutDirection()
            if let backImage = image {
                button.setImage(backImage, for: .normal)
                button.addTarget(self, action: #selector(BaseVC.leftItemPressed), for: .touchUpInside)
                button.frame = CGRect(x: 0, y: 0, width: backImage.size.width, height: backImage.size.height)
                button.clipsToBounds = true
                button.titleLabel?.sizeToFit()
            }
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
    }

    
    @objc func leftItemPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
