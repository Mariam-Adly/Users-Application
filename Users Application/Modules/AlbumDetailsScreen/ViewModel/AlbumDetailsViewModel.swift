//
//  AlbumDetailsViewModel.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import Foundation
class AlbumDetailsViewModel{
    var albumId : Int?
    init(albumId: Int? = nil) {
        self.albumId = albumId
    }
    var isSearching = false
    var filterPhotos : [Photo]?
    var bindResultToPhotosCollectionViewController : (()->()) = {}
    var photosResult : [Photo]?{
        didSet{
            bindResultToPhotosCollectionViewController()
        }
    }
    
    func getPhotos(albumID : Int){
        NetworkServices.getPhotos(albumID: albumID){
            [weak self](result) in
            self?.photosResult = result
        }
    }
    
    func getPhotosCount()->Int{
        if isSearching{
            return filterPhotos?.count ?? 0
        }else{
            return photosResult?.count ?? 0
        }
    }
    
    
    func getAlbumsAtIndex(index : Int)-> Photo{
        if isSearching{
            return filterPhotos?[index] ?? Photo()
        }else{
            return photosResult?[index] ?? Photo()
        }
    }
    
}
