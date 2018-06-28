//
//  TrackItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct TrackItem: Codable {
    static var shared: TrackItem?
    
    var album: AlbumItem
    var artists: [ArtistItem] //array of artist objects simpl
    var disc_number: Int
    var duration_ms: Int
    var external_urls: [ExternalURL]
    var href: String
    var id: String
    var is_playable: Bool
    var name: String
    var preview_url: String
    var track_number: Int
    var uri: String
    
    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case disc_number
        case duration_ms
        case external_urls
        case href
        case id
        case is_playable
        case name
        case preview_url
        case track_number
        case uri
    }
}

struct TrackItems: Codable {
    static var shared: TrackItems?
    let items: [TrackItem]
}
