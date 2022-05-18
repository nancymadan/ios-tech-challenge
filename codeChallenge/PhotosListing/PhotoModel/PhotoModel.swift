//
//  PhotoModel.swift
//  codeChallenge
//
//  Created by Nancy on 17/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct PhotosModel: Codable {
    let photos: Photos?
     let stat: String?
 }

 // MARK: - Photos
 struct Photos: Codable {
     let page, pages, perpage, total: Int?
     let photo: [Photo]?
 }

 // MARK: - Photo
 struct Photo: Codable {
     let title: String?
     let description: Description?
     let datetaken: String?
     let urlT: String?
     
     enum CodingKeys: String, CodingKey {
         case  title, datetaken
         case description
         case urlT = "url_t"

     }
}

 // MARK: - Description
 struct Description: Codable {
     let content: String?
     enum CodingKeys: String, CodingKey {
             case content = "_content"
         }
 }
