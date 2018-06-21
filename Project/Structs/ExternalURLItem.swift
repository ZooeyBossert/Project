//
//  ExternalURLItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct ExternalURL: Codable {
    static var shared: ExternalURL?
    
    var key: String
    var value: String

    enum CodingKeys: String, CodingKey {
        case key
        case value
    }
}

struct ExternalURLs: Codable {
    static var shared: ExternalURL?
    let items: [ExternalURL]
}
