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
    case signIn(param: SigninRequest)
}


extension LoginServices: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/user/register"
        case .signIn:
            return "/user/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp,
             .signIn:
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
        case .signIn(let param):
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
