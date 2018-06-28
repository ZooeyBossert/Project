//
//  ArtistItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct ArtistItem: Codable {
    static var shared: ArtistItem?

    var name: String
}

struct ArtistItems: Codable {
    static var shared: ArtistItems?
    let items: [ArtistItem]
}
