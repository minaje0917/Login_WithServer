//
//  LoginServices.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/22.
//

import Foundation
import Moya

enum LoginServices {
    case signUp(param: SignupRequest)
}


extension LoginServices: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/user/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .signUp(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
