//
//  AlbumsViewModel.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileViewModel{
    
    var bindResultToProfileViewController : (()->()) = {}
    var userResult : User?{
        didSet{
            bindResultToProfileViewController()
        }
    }
    var albums : PublishSubject<[Album]> = PublishSubject()
    var albumsResult : [Album]?


    func getUser(userID : Int){
        NetworkServices.getUser(userID: userID){
            [weak self](result) in
            self?.userResult = result
        }
    }
    
    func getUserAtIndex()-> User{
        return userResult ?? User()
    }
    
    
    func getAlbums(userID : Int){
        NetworkServices.getAlbums(userID: userID){
            [weak self](result) in
            self?.albumsResult = result
            self?.albums.onNext(result ?? [Album()])
            self?.albums.onCompleted()
        }
    }
    
    func getAlbumsAtIndex(index : Int)-> Album{
        return albumsResult?[index] ?? Album()
    }

}
