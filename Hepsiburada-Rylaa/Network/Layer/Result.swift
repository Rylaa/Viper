//
//  Result.swift
//  Yusuf-Demirkoparan
//
//  Created by yusuf demirkoparan.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}
