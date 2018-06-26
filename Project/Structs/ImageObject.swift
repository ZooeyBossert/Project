//
//  ImageObject.swift
//  Project
//
//  Created by Zooey Bossert on 26-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct ImageObject: Codable {
    var height: Int
    var url : String
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case height
        case url
        case width
    }
}

struct ImageObjects: Codable {
    let items: [ImageObject]
}
