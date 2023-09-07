//
//  ViewController.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileViewController: UIViewController {

    @IBOutlet weak var albumsTV: UITableView!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var userName: UILabel!
    var profileVM : ProfileViewModel?
    var networkIndecator : UIActivityIndicatorView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileVM = ProfileViewModel()
        
        albumsTV.delegate = self
        
        networkIndecator = UIActivityIndicatorView(style: .large)
        networkIndecator.color = UIColor.black
        networkIndecator.center = view.center
        networkIndecator.startAnimating()
        view.addSubview(networkIndecator)
        
        albumsTV.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "albumCell")
        
        let userID = Int.random(in: 0..<10)
        profileVM?.getUser(userID: userID)
        profileVM?.getAlbums(userID: userID)
        
        setupTable()
        
          profileVM?.bindResultToProfileViewController = {
              let address1 = (self.profileVM?.getUserAtIndex().address?.street ?? "") + ", " + (self.profileVM?.getUserAtIndex().address?.suite ?? "")
              let address2 = (self.profileVM?.getUserAtIndex().address?.city ?? "") + ", " + (self.profileVM?.getUserAtIndex().address?.zipcode ?? "")
              DispatchQueue.main.async {
                  self.userName.text = self.profileVM?.getUserAtIndex().name
                  self.userAdd.text = address1 + address2
              }
          }
    }
    
    func setupTable(){
        profileVM?.albums.bind(to: albumsTV.rx.items(cellIdentifier: "albumCell",cellType: AlbumTableViewCell.self)){
            index , element , cell in
            self.networkIndecator.stopAnimating()
            cell.albumName.text = element.title
        }.disposed(by: disposeBag)
    }
}

extension ProfileViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "AlbumDetailsVC") as! AlbumDetailsViewController
        
        let controller = AlbumDetailsViewModel(albumId: profileVM?.getAlbumsAtIndex(index: indexPath.row).id)
        albumDetailsVC.albumDetailsVM = controller
        self.navigationController?.pushViewController(albumDetailsVC, animated: true)
    }
}


