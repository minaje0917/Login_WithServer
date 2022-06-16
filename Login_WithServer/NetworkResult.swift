//
//  NetworkResult.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/16.
//

import Foundation


enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
