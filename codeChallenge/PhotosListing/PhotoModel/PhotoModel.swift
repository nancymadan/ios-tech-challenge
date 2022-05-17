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
     let id, owner, secret, server: String?
     let farm: Int?
     let title: String?
     let ispublic, isfriend, isfamily: Int?
     let description: Description?
     let datetaken: String?
     let datetakengranularity: Int?
     let datetakenunknown, tags: String?
     let urlT: String?
     let heightT, widthT: Int?
     
     enum CodingKeys: String, CodingKey {
         case id, owner, secret, server, title, datetaken, datetakenunknown, tags
         case farm, ispublic, isfriend, isfamily, datetakengranularity
         case description
         case urlT = "url_t"
         case heightT = "height_t"
         case widthT = "width_t"

     }
}

 // MARK: - Description
 struct Description: Codable {
     let content: String?
     enum CodingKeys: String, CodingKey {
             case content = "_content"
         }
 }
