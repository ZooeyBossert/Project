//
//  AlbumItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct AlbumItem: Codable {
    var album_type: String
    var artists: [String] // ook lijst van simplefied objecten
    var external_urls: [ExternalURL]
    var href: String
    var id: String
    //var images: [Object] hoe dit??
    var name: String
    var type: String
    var uri: String
    
    enum CodingKeys: String, CodingKey {
        case album_type
        case artists
        case external_urls
        case href
        case id
        //case images
        case name
        case type
        case uri
    }
}

struct AlbumItems: Codable {
    static var shared: AlbumItems?
    let items: [AlbumItem]
}
