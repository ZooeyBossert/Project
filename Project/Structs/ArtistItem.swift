//
//  ArtistItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct ArtistItem: ResultItem, Codable {
    var external_urls: [ExternalURL]
    var genre: [String]
    var href: String
    var id: String
    var images: URL //array van image objecten
    var name: String
    var uri: String
    
    enum CodingKeys: String, CodingKey {
        case external_urls
        case genre
        case href
        case id
        case images
        case name
        case uri
    }
}

struct ArtistItems: Codable {
    static var shared: ArtistItems?
    let items: [ArtistItem]
}
