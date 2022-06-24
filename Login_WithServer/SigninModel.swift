//
//  SigninModel.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/24.
//
import Foundation


struct SigninModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SigninResponse
}

struct SigninResponse: Codable {
    let email: String
}
