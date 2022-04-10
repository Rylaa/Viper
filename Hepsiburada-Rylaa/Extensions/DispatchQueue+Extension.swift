//
//  DispatchQueue+Extension.swift
//  Yusuf Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import UIKit

extension DispatchQueue {
    
    static func main(_ main: @escaping (() -> ())) {
        DispatchQueue.main.async {
            main()
        }
    }
    
    static func main(_ asyncAfter: CGFloat,_ main: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncAfter ) {
            main()
        }
    }
    
}
