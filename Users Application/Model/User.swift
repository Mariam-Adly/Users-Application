//
//  Album.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation

struct User : Decodable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
}

// MARK: - Address
struct Address: Decodable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Decodable {
    var lat, lng: String
}

// MARK: - Company
struct Company: Decodable {
    var name, catchPhrase, bs: String
}

