//
//  AlbumDetailsTableViewController.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import UIKit
import SDWebImage

class AlbumDetailsViewController: UIViewController {

    
    @IBOutlet weak var photosSearch: UISearchBar!
    @IBOutlet weak var photosCV: UICollectionView!
    var albumDetailsVM : AlbumDetailsViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCV.dataSource = self
        photosCV.delegate = self
        photosSearch.delegate = self
        
        photosCV.register(UINib(nibName: "AlbumDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "albumDetailsCell")
        
        albumDetailsVM?.getPhotos(albumID: albumDetailsVM?.albumId ?? 0)
        albumDetailsVM?.bindResultToPhotosCollectionViewController = {
            DispatchQueue.main.async {
                self.photosCV.reloadData()
            }
        }
        
    }
    
}

extension AlbumDetailsViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imgViewerVC = self.storyboard?.instantiateViewController(withIdentifier: "ImgViewerVC") as! ImageViewerViewController
        let data = albumDetailsVM?.getAlbumsAtIndex(index: indexPath.row)
        imgViewerVC.photo = data
        self.navigationController?.pushViewController(imgViewerVC, animated: true)
        
        
    }
}

extension AlbumDetailsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return albumDetailsVM?.getPhotosCount() ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumDetailsCell", for: indexPath) as! AlbumDetailsCollectionViewCell
        let data = albumDetailsVM?.getAlbumsAtIndex(index: indexPath.row)
        cell.albumPhotos.sd_setImage(with: URL(string: data?.url ?? ""),placeholderImage: UIImage(named: "product"))
        return cell
    }
}

extension AlbumDetailsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-3 , height: (view.frame.size.width/3)-3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
extension AlbumDetailsViewController : UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            albumDetailsVM?.isSearching = false
            view.endEditing(true)
            albumDetailsVM?.filterPhotos?.removeAll()
            photosCV.reloadData()
        }else{
            albumDetailsVM?.isSearching = true
            albumDetailsVM?.filterPhotos?.removeAll()
            albumDetailsVM?.filterPhotos = albumDetailsVM?.photosResult?.filter { photo in
                guard let title = photo.title else {
                    return false
                }
                return title.localizedCaseInsensitiveContains(searchText)
            }
            photosCV.reloadData()
        }
    }
}
