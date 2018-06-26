//
//  UserProfile.swift
//  Project
//
//  Created by Zooey Bossert on 26-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    static var shared: UserProfile?
    var id: String
    var images: ImageObject
    
    enum CodingKeys: String, CodingKey {
        case id
        case images
    }
}

