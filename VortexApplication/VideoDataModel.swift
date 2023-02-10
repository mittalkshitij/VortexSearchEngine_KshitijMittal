//
//  VideoDataModel.swift
//  VortexApplication
//
//  Created by Kshitij Mittal on 09/02/23.
//

import Foundation

struct VideoDataModel : Codable {
    
    let page : Int?
    let per_page : Int?
    let videos : [Video]?
    let total_results : Int?
    let next_page : String?
    
}

struct Video : Codable {
    
    let video_files : [VideoFiles]?
    let user : User?
    let url : String?
    let image : String?
    
}

struct User : Codable {
    
    let id : Int?
    let name : String?
}

struct VideoFiles : Codable {
    
    let id : Int?
    let quality : String?
    let link : String?
}
