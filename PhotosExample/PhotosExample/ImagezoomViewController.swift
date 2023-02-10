//
//  ImagezoomViewController.swift
//  PhotosExample
//
//  Created by 양가연 on 2023/02/10.
//

import UIKit
import Photos

class ImagezoomViewController: UIViewController, UIScrollViewDelegate {

    var asset: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var imageView: UIImageView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in self.imageView.image = image})
        // Do any additional setup after loading the view.
    }

}
