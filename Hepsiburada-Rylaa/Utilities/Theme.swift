//
//  Theme.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

let theme = Theme()

final class Theme {
    var font: UIFontStyle {
        return FontStyle()
    }
    
    var color: UIColorStyle {
        return ColorStyle()
    }
    
    var appTheme: UIAppThemeStyle {
        return AppThemeStyle()
    }
}

protocol UIFontStyle {}
protocol UIColorStyle {
    var primary: UIColor { get }
    var secondary: UIColor { get }
    var tertiary: UIColor { get }
}
protocol UIAppThemeStyle {
    func setCustomBackButton()
    func setupNavigationBarStyle()
}

final class FontStyle: UIFontStyle { }
final class ColorStyle: UIColorStyle {
    var secondary: UIColor {
        return UIColor(named: "secondary")!
    }
    
    var tertiary: UIColor {
        return UIColor(named: "tertiary")!
    }
    
    var primary: UIColor {
        return UIColor(named: "primary")!
    }
}


final class AppThemeStyle: UIAppThemeStyle {
    func setupNavigationBarStyle() {
        
    }
    
    
    func setCustomBackButton() {
        let backImage = UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 16, vertical: -80.0), for: .default)
    }

    
}
