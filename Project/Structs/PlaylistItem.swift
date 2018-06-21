//
//  PlaylistItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct PlaylistItem: ResultItem, Codable {
    var collaborative: Bool
    var external_urls: [ExternalURL]
    var href: String
    var id: String
//    var images: String //of images
    var name: String
    var owner: String
    var publ: Bool
    var snapshot_id: String
    var tracks: [TrackItem]
    var type: String
    var uri: String
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case external_urls 
        case href
        case id
//        case images
        case name
        case owner
        case publ
        case snapshot_id
        case tracks
        case type
        case uri
    }
}

struct PlaylistItems: Codable {
    static var shared: PlaylistItems?
    let items: [PlaylistItem]
}
