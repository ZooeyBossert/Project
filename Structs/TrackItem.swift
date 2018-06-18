////
////  TrackItem.swift
////  Project
////
////  Created by Zooey Bossert on 18-06-18.
////  Copyright © 2018 Zooey Bossert. All rights reserved.
////
//
//import Foundation
//
//struct TrackItem: Codable {
//    var album: Object //simplified albumobject (albumItem)
//    var artists: [String] //array of artist objects simpl
//    var available_markets: [String]
//    var disc_number: Int
//    var duration_ms: Int
//    var eplicit: Bool
//    var external_ids: Object // ID external object
//    var external_urls: URL //object
//    var href: String
//    var id: String
//    var is_playable: Bool
//    var linked_from: Object //linked trach object
//    var name: String
//    var popularity: Int
//    var preview_url: String
//    var track_number: Int
//    var type: String
//    var uri: String
//    
//    enum CodingKeys: String, CodingKey {
//        case album
//        case artists
//        case available_markets
//        case disc_number
//        case duration_ms
//        case eplicit
//        case external_ids
//        case external_urls = "external_urls"
//        case href
//        case id
//        case is_playable
//        case linked_from
//        case name
//        case popularity
//        case preview_url
//        case track_number
//        case type
//        case uri
//    }
//}
//
//struct TrackItems: Codable {
//    static var shared: TrackItems?
//    let items: [TrackItem]
//}
