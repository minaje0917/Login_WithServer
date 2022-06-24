//
//  SigninRequest.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/24.
//


import Foundation


struct SigninRequest: Codable {
    var email: String
    var password: String
    
    init(_ id: String,_ password: String) {
        self.email = id
        self.password = password
    }
}
