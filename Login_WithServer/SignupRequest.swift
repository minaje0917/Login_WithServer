//
//  SignupRequest.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/22.
//

import Foundation


struct SignupRequest: Codable {
    var id: String
    var password: String
    
    init(_ id: String,_ password: String) {
        self.id = id
        self.password = password
    }
}
