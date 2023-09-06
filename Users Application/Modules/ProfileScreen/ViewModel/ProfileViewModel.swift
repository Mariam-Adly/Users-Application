//
//  AlbumsViewModel.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation
class ProfileViewModel{
    
    var bindResultToProfileViewController : (()->()) = {}
    var userResult : User?{
        didSet{
            bindResultToProfileViewController()
        }
    }
    
    var bindResultToAlbumsTableViewController : (()->()) = {}
    var albumsResult : [Album]?{
        didSet{
            bindResultToAlbumsTableViewController()
        }
    }

    func getUser(userID : Int){
        NetworkServices.getUser(userID: userID){
            [weak self](result) in
            self?.userResult = result
            print("jessy\(self?.userResult)")
        }
    }
    
    func getUserAtIndex()-> User{
        return userResult ?? User()
    }
    
    
    func getAlbums(userID : Int){
        NetworkServices.getAlbums(userID: userID){
            [weak self](result) in
            self?.albumsResult = result
        }
    }
    
    func  getAlbumsCount()->Int{
      return albumsResult?.count ?? 0
    }
    
    func getAlbumsAtIndex(index : Int)-> Album{
        return albumsResult?[index] ?? Album()
    }
    
}
