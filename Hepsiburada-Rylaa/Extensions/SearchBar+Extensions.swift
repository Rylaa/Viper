//
//  SearchBar+Extensions.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

extension UISearchBar {
    func setupSearchBar(background: UIColor = .white, inputText: UIColor = .black, placeholderText: UIColor = .gray, image: UIColor = .black) {
        self.searchBarStyle = .minimal
        self.barStyle = .default
        for view in self.subviews {
            for subview in view.subviews {
                if subview is UITextField {
                    if let textField: UITextField = subview as? UITextField {
                        textField.backgroundColor = background
                        textField.textColor = inputText
                        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                                             attributes: [NSAttributedString.Key.foregroundColor : placeholderText])
                        
                        if let leftView = textField.leftView as? UIImageView {
                            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                            leftView.tintColor = image
                        }
                        
                        let backgroundView = textField.subviews.first
                        backgroundView?.backgroundColor = background
                        backgroundView?.layer.cornerRadius = 10.5
                        backgroundView?.layer.masksToBounds = true
                        
                    }
                }
            }
            
        }
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = background
            textField.textColor = inputText
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderText])
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = image
            }
            
        }
        
    }
}
