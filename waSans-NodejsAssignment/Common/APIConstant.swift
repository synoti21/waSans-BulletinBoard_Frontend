//
//  APIConstant.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/15.
//

import Foundation

struct APIConstants{
    static let baseURL = "http://localhost:8080"
}

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
