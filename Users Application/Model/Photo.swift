//
//  Photo.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation

// MARK: - WelcomeElement
struct Photo : Decodable {
    var albumID, id: Int?
    var title: String?
    var url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

