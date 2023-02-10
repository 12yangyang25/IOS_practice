
import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier: String = "cell"
    
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        
        guard let cameraRollCollection = cameraRoll.firstObject else{
            return
        }
        
        let fetchOptions:PHFetchOptions = {
            let Options: PHFetchOptions = PHFetchOptions()
            Options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            return Options
        }()

        fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근허가됨")
            self.requestCollection()
            self.tableView.reloadData()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in switch status {
            case .authorized:
                print("접근허가됨")
                self.requestCollection()
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            case .denied:
                print("접근 불허")
            default: break
            }})
        case .restricted:
            print("접근 제한")
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil) { image, _ in cell.imageView?.image = image
        }
        
        return cell
    }
    
}
