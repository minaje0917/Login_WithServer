//
//  LoginService.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/16.
//

import Foundation
import Alamofire

struct LoginService {
    
    static let shared = LoginService()
    
    func getLoginInfo(completion : @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = ""
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        let dataRequest = AF.request(URL, method: .get, encoding: JSONEncoding.default, headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
                case .success:
                    guard let statusCode = dataResponse.response?.statusCode else {return}
                    guard let value = dataResponse.value else {return}
                    let networkResult = self.judgeStatus(by: statusCode, value)
                    completion(networkResult)
            case . failure: completion(.pathErr)

            }
        }
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any>
    {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
            
        }
    }
    private func isValidData (data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(LoginDataModel.self, from: data)
        else {return .pathErr}
        return .success(decodeData.id)
    }
}
