//
//  SignupRequest.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/22.
//

import Foundation


struct SignupRequest: Codable {
    var email: String
    var password: String
    
    init(_ id: String,_ password: String) {
        self.email = id
        self.password = password
    }
}
