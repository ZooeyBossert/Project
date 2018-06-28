//
//  MusicItem.swift
//  Project
//
//  Created by Zooey Bossert on 27-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct MusicItem: Codable {
    static var shared: MusicItem?
    
    var name: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

struct MusicItems: Codable {
    static var shared: MusicItems?
    let items: [MusicItem]
}
