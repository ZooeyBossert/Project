//
//  ArtistItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct ArtistItem: Codable {
    var external_urls: URL // meerdere url objecten voor artiest
    var followers: [String] // lijst van andere artiesten simplefied
    var genre: [String]
    var href: String
    var id: String
    var images: URL //array van image objecten
    var name: String
    var popularity: Int
    var type: String
    var uri: String
    
    enum CodingKeys: String, CodingKey {
        case external_urls = "external_urls"
        case followers
        case genre
        case href
        case id
        case images
        case name
        case popularity
        case type
        case uri
    }
}

struct ArtistItems: Codable {
    static var shared: ArtistItems?
    let items: [ArtistItem]
}
