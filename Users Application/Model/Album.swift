//
//  Album.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation

// MARK: - WelcomeElement
struct Album: Decodable {
    var userID, id: Int?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

