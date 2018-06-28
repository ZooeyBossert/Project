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
    var artists: [ArtistItem] 
    var href: URL
    var id: String
    var name: String
    var preview_url: URL?
    var uri: String

}

struct TopStruct: Codable {
    let tracks: Tracks
}

struct Tracks: Codable {
    static var shared: Tracks?
    let items: [TrackItem]
}


