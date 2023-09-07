//
//  ImageViewerViewController.swift
//  Users Application
//
//  Created by mariam adly on 07/09/2023.
//

import UIKit
import SDWebImage

class ImageViewerViewController: UIViewController {

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var photo : Photo?
    var images : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
     
        scrollView.delegate = self
        imgView.sd_setImage(with: URL(string: photo?.url ?? ""),placeholderImage: UIImage(named: "product"))
        shareBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        images.append(photo?.url ?? "")
    }
    
    @objc func buttonAction(sender: UIBarButtonItem!) {
        let shareImg = UIActivityViewController(activityItems: images, applicationActivities: nil)
        
        shareImg.completionWithItemsHandler = { _, bool, _ , _ in
            if bool {
               print("it is done!")
            }
        }
       // shareImg.popoverPresentationController?.barButtonItem = sender
       // shareImg.popoverPresentationController?.permittedArrowDirections = .any
        shareImg.popoverPresentationController?.sourceView = self.view
        present(shareImg , animated: true , completion: nil)
    }
    
}
extension ImageViewerViewController : UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
}
