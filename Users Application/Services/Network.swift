//
//  Network.swift
//  Users Application
//
//  Created by mariam adly on 07/09/2023.
//

import Foundation
import Moya

enum MyAPI {
    case getUser(userID: Int)
    case getAlbums(userID: Int)
    case getPhotos(albumID : Int)
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getUser(let userID):
            return "/users/\(userID)"
        case .getAlbums(let userID):
            return "/users/\(userID)/albums"
        case .getPhotos(let albumID):
            return "/albums/\(albumID)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        case .getAlbums:
            return .get
        case .getPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUser, .getAlbums, .getPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
