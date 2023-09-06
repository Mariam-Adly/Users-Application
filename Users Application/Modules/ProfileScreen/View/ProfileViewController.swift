//
//  ViewController.swift
//  Users Application
//
//  Created by mariam adly on 06/09/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var albumsTV: UITableView!
    @IBOutlet weak var userAdd: UILabel!
    @IBOutlet weak var userName: UILabel!
    var profileVM : ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileVM = ProfileViewModel()
        
        albumsTV.delegate = self
        albumsTV.dataSource = self
        
        albumsTV.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "albumCell")
        
        let userID = Int.random(in: 0..<10)
        profileVM?.getUser(userID: userID)
        profileVM?.getAlbums(userID: userID)
        
        
        
          profileVM?.bindResultToProfileViewController = {
              let address1 = (self.profileVM?.getUserAtIndex().address?.street ?? "") + ", " + (self.profileVM?.getUserAtIndex().address?.suite ?? "")
              let address2 = (self.profileVM?.getUserAtIndex().address?.city ?? "") + ", " + (self.profileVM?.getUserAtIndex().address?.zipcode ?? "")
              DispatchQueue.main.async {
                  self.userName.text = self.profileVM?.getUserAtIndex().name
                  self.userAdd.text = address1 + address2
              }
          }
        
        profileVM?.bindResultToAlbumsTableViewController = {
            DispatchQueue.main.async {
                self.albumsTV.reloadData()
            }
        }
        
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

extension ProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileVM?.getAlbumsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        let albumData = profileVM?.getAlbumsAtIndex(index: indexPath.row)
        cell.albumName.text = albumData?.title
        return cell
    }
    
    
    
}

