//
//  NetworkService.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation
import Alamofire
import Moya

class NetworkServices {
   
    static func getUser(userID: Int,completionHandler: @escaping (User?) -> Void ){
        let provider = MoyaProvider<MyAPI>()
        provider.request(.getUser(userID: userID)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                do{
                let jsonData =  try JSONDecoder().decode(User.self, from: data)
                    completionHandler(jsonData)
                }catch{
                print(error.localizedDescription)
            }
            case .failure(let error):
                completionHandler(nil)
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    static func getAlbums(userID: Int,completionHandler: @escaping ([Album]?) -> Void ){
        
        let provider = MoyaProvider<MyAPI>()
        provider.request(.getAlbums(userID: userID)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                do{
                let jsonData =  try JSONDecoder().decode([Album].self, from: data)
                    completionHandler(jsonData)
                }catch{
                print(error.localizedDescription)
            }
            case .failure(let error):
                completionHandler(nil)
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    

    
    static func getPhotos(albumID: Int,completionHandler: @escaping ([Photo]?) -> Void ){
        
        let provider = MoyaProvider<MyAPI>()
        provider.request(.getPhotos(albumID: albumID)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                do{
                let jsonData =  try JSONDecoder().decode([Photo].self, from: data)
                    completionHandler(jsonData)
                }catch{
                print(error.localizedDescription)
            }
            case .failure(let error):
                completionHandler(nil)
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
