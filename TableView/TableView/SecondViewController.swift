//
//  SecondViewController.swift
//  TableView
//
//  Created by 양가연 on 2023/01/20.
//

import UIKit

class SecondViewController: UIViewController {

    var textToset:String?
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textLabel.text = textToset
    }


}
