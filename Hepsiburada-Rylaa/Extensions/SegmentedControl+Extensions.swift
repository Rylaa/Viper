//
//  SegmentedControl+Extensions.swift
//  Yusuf Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

extension UISegmentedControl {
    func selectedSegmentTintColor(_ color: UIColor) {
            self.setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
}
