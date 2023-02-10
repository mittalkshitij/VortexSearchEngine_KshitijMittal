//
//  ViewController.swift
//  VortexApplication
//
//  Created by Kshitij Mittal on 08/02/23.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var welcomeTextField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var segmentView : UISegmentedControl!
    var photoData: [Photo]?
    var videoData: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func seachButton(_ sender: UIButton) {
        
        if segmentView.selectedSegmentIndex == 0 {
            searchPhotoAPI(query: searchBar.text!)
        } else{
            searchVideoAPI(query: searchBar.text!)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if (segue.identifier == "searchToResultPhoto")
//        {
//            let destination = segue.destination as? PhotoViewController
//            destination?.result = self.photoData
//        }
        
        let destination = segue.destination as? PhotoViewController
        destination?.type = segmentView.selectedSegmentIndex
        
        if(segmentView.selectedSegmentIndex == 0){
            
            destination?.result = self.photoData
        }else{
            destination?.resultVideo = self.videoData
        }
        
       
    }
    
    func searchPhotoAPI(query : String){
        
        if(query == ""){
            let alert = UIAlertController.init(title: "Error", message: "Please Enter Search Query", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                
            }))
            self.present(alert, animated: true)
        }else{
           
            let url : URL = URL.init(string: "https://pexelsdimasv1.p.rapidapi.com/v1/search?query=\(query)")!
            //url -> url request
            //url request -> url session
            
            let headers = [
               // "Authorization": "undefined",
                "X-RapidAPI-Key": "fb3c4b45a0msh92445aea0665df4p1e9516jsn267725277278",
                "X-RapidAPI-Host": "PexelsdimasV1.p.rapidapi.com"
            ]
            
            var urlRequest : URLRequest = URLRequest.init(url: url)
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpMethod = "GET"
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                
                if error != nil{
                    
                    print(error!)
                }
                else
                {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse!)
                    
                    let decoder = JSONDecoder()
                    
                    do{
                        let model = try decoder.decode(PhotoDataModel.self, from: data!)
                       
                        self.photoData = model.photos
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "searchToResultPhoto", sender: nil)
                        }
                        
                    }
                    catch{
                        print("Decode Error")
                    }
                }
            }
            task.resume()


        }
    }
    
    func searchVideoAPI(query : String) {
        
        if(query == ""){
            let alert = UIAlertController.init(title: "Error", message: "Please Enter Search Query", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                
            }))
            self.present(alert, animated: true)
        }else{
            
            let url : URL = URL.init(string: "https://pexelsdimasv1.p.rapidapi.com/videos/search?query=\(query)")!
      

            let headers = [
                // "Authorization": "undefined",
                "X-RapidAPI-Key": "fb3c4b45a0msh92445aea0665df4p1e9516jsn267725277278",
                "X-RapidAPI-Host": "PexelsdimasV1.p.rapidapi.com"
            ]
            
            var urlRequest : URLRequest = URLRequest.init(url: url)
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpMethod = "GET"
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                
                if error != nil{
                    
                    print(error!)
                }
                else
                {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse!)
                    
                    let decoder = JSONDecoder()
                    
                    do{
                        let model = try decoder.decode(VideoDataModel.self, from: data!)
                        
                        self.videoData = model.videos
                        
                        // --
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "searchToResultPhoto", sender: nil)
                        }
                        
                    }
                    catch{
                        print("Decode Error")
                    }
                }
            }
            task.resume()
            
            
        }
    
    }
        
}

