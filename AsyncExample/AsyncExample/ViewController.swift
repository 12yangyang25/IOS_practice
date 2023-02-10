//
//  ViewController.swift
//  AsyncExample
//
//  Created by 양가연 on 2023/02/10.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView:UIImageView!
    
    @IBAction func touchUpDownloadBtn(_ sender: UIButton){
        //이미지 다운로드 -> 이미지 뷰에 셋팅
        //https://pbs.twimg.com/media/FS8dvLLVUAAcNva?format=jpg&name=medium
        
        let imageURL: URL = URL(string: "https://pbs.twimg.com/media/FS8dvLLVUAAcNva?format=jpg&name=large")!
    
        OperationQueue().addOperation{
            let imageData: Data = try! Data.init(contentsOf: imageURL)
            
            let image: UIImage = UIImage(data: imageData)!
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

