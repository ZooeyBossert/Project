//
//  TokenItem.swift
//  Project
//
//  Created by Zooey Bossert on 13-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct TokenItem: Codable {
    
    static var shared: TokenItem?
    
    var access_token: String
    var token_type: String
    var scope: String
    var expires_in: Int
    var refresh_token: String
    
    enum CodingKeys: String, CodingKey {
        case access_token
        case token_type
        case scope
        case expires_in
        case refresh_token
    }
}
