//
//  ViewController.swift
//  FriendsCollection
//
//  Created by 양가연 on 2023/02/17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    var numberOfCell: Int = 10
    var friends: [Friend] = []
    let cellIdentifier: String = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FriendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! FriendCollectionViewCell
        
        let friend: Friend = self.friends[indexPath.item]
        cell.nameAgeLabel.text = friend.nameAndAge
        cell.adressLabel.text = friend.fullAddress
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth: CGFloat = UIScreen.main.bounds.width / 2.0
        
        flowLayout.estimatedItemSize = CGSize(width: halfWidth - 30, height: 90)
        
        self.collectionView.collectionViewLayout = flowLayout
        
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "friends") else {
            return
        }
        
        do{
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        } catch{
            print(error.localizedDescription)
        }
        
        collectionView.reloadData()
    }


}

