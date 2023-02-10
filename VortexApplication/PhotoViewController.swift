//
//  PhotoViewController.swift
//  VortexApplication
//
//  Created by Kshitij Mittal on 09/02/23.
//

import UIKit

import AVKit
import AVFoundation

class PhotoViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mytable: UITableView!
    
    var result: [Photo]? = []
    var resultVideo: [Video]? = []
    var imageArray : [UIImage]? = []
    var type : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkdata()
        mytable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func checkdata() {
        guard let data = result else {
            return
        }
        print(data)
    }
    
    //getting image data from url
    func getImageData(urlString : String) -> UIImage{
        
        let url = URL.init(string: urlString)
        do{
            let imageData = try Data.init(contentsOf: url!)
            let image = UIImage.init(data: imageData)
            
            return image!
        }catch{
            return UIImage.init(named: "image")!
        }
        
    }
    
    //play video using AVPlayer
    func playVideo(url : URL){
        
        let player = AVPlayer(url: url)
        
        let viewController = AVPlayerViewController()
        viewController.player = player
        
        self.present(viewController, animated: true){
            
            viewController.player?.play()
        }
    }
    
    // MARK: - UITableView
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(type == 0){
            return result!.count
        }else{
            return resultVideo!.count
        }
    }
    
    // defining values and assigning data to data cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? PhotoTableViewCell
        
        if (type == 0) {
            let obj = self.result![indexPath.row]
            
            cell?.photoName.text = obj.photographer
            cell?.photoDetail.text = obj.alt
            
            
            //Background Related task on global thread
            DispatchQueue.global(qos: .utility).async{
                
                let image = self.getImageData(urlString: (obj.src?.tiny)!)
                
                //UI Related task on main thread
                DispatchQueue.main.async {
                    cell?.photoImage.image = image
                    
                    if self.imageArray!.count > indexPath.row {
                        self.imageArray?[indexPath.row] = image
                    }else{
                        
                        self.imageArray?.append(image)
                    }
                    
                }
            }
        }
        else{
            
            let obj = resultVideo![indexPath.row]
            cell?.photoName.text = obj.user?.name
            cell?.photoDetail.text = obj.url
            
            DispatchQueue.global(qos: .utility).async{
                
                let image = self.getImageData(urlString: (obj.image)!)
                
                //UI Related task on main thread
                DispatchQueue.main.async {
                    
                    cell!.photoImage.image = image
                }
                
            }
        }
        return cell!
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            150.0
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Data Section - \(section)"
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let storyboard = UIStoryboard.init(name : "Main",bundle : nil)
            let viewPhoto = storyboard.instantiateViewController(withIdentifier: "ViewPhoto") as? ViewPhotoVC
            
            
            if(type == 0){
                let obj = self.result![indexPath.row]
                let image = self.imageArray![indexPath.row]
                viewPhoto?.singleImage = obj
                viewPhoto?.originalImage = image
                self.navigationController?.pushViewController(viewPhoto!, animated: true)
            }else{
                
                let obj = resultVideo![indexPath.row]
                let url = URL(string: obj.video_files![0].link!)!
                
                playVideo(url: url)
            }
            
            
          
            
        }
    
    }
