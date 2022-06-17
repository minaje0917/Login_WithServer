


import Foundation
import Moya

enum LoginService {
    case signUp(param: SignupRequest)
    case signIn(param: SigninRequest)
}

extension LoginService: TargetType {
    public var baseURL: URL{
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/users/register"
        case .signIn:
            return "users/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn,.signUp:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)
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
            return["Content-Type":"application/json"]
        }
    }
}
