//
//  SignupModel.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/23.
//

import Foundation


struct SignupModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SignupResponse
}

struct SignupResponse: Codable {
    let id: String
}
