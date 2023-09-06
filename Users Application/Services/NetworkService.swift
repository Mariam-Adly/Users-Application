//
//  NetworkService.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation
import Alamofire

class NetworkServices {
    
    static func getUser(userID: Int,completionHandler: @escaping (User?) -> Void ){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userID)")
                guard let newUrl = url else {
                    return
                }
                AF.request(newUrl,method: .get)
                    .validate().response { resp in
                        switch resp.result{
                        case .success(let data):
                            do{
                                if let data = data{
                                    let jsonData =  try JSONDecoder().decode(User.self, from: data)
                                        completionHandler(jsonData)
                                }
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            completionHandler(nil)
                        }
                    }
        
    }
    
    static func getAlbums(userID: Int,completionHandler: @escaping ([Album]?) -> Void ){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userID)/albums")
                guard let newUrl = url else {
                    return
                }
                AF.request(newUrl,method: .get)
                    .validate().response { resp in
                        switch resp.result{
                        case .success(let data):
                            do{
                                if let data = data{
                                    let jsonData =  try JSONDecoder().decode([Album].self, from: data)
                                        completionHandler(jsonData)
                                }
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            completionHandler(nil)
                        }
                    }
        
    }
    

    
    static func getPhotos(albumID: Int,completionHandler: @escaping ([Photo]?) -> Void ){
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums/\(albumID)/photos")
                guard let newUrl = url else {
                    return
                }
                AF.request(newUrl,method: .get)
                    .validate().response { resp in
                        switch resp.result{
                        case .success(let data):
                            do{
                                if let data = data{
                                    let jsonData =  try JSONDecoder().decode([Photo].self, from: data)
                                        completionHandler(jsonData)
                                }
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            completionHandler(nil)
                        }
                    }
        
    }
    
}
