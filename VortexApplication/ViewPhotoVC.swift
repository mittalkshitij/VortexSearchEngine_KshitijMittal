//
//  ViewPhotoVCViewController.swift
//  VortexApplication
//
//  Created by Kshitij Mittal on 09/02/23.
//

import UIKit

class ViewPhotoVC: UIViewController {
    
    var singleImage : Photo?
    var tinyImage : UIImage!
    var originalImage : UIImage!
    
    @IBOutlet weak var completeImage : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.completeImage.image = self.originalImage
        

        // Do any additional setup after loading the view.
    }
    
    func downloadImage(){
        
        let url : URL = URL.init(string: (singleImage?.src?.original)!)!

        let session = URLSession.shared
        
        let task = session.downloadTask(with: url) { url, response, error in
            
            do{
                let data = try Data.init(contentsOf: url!)
                print(data)
                
                DispatchQueue.main.async {
                    self.completeImage.image = UIImage.init(data: data)
                }
            }catch{
                
            }
        }
        
        task.resume()
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
