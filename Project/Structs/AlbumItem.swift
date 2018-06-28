//
//  AlbumItem.swift
//  Project
//
//  Created by Zooey Bossert on 18-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct AlbumItem: Codable {
    static var shared: AlbumItem?

    var images: [ImageObject]
    var name: String
}

struct AlbumItems: Codable {
    static var shared: AlbumItems?
    let items: [AlbumItem]
}
