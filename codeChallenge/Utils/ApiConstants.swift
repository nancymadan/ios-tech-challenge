//
//  ApiConstants.swift
//  codeChallenge
//
//  Created by Nancy on 17/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import Foundation


enum Apis: String {
    case photoApi
    
    func getApiValue() -> String {
        switch self {
        case .photoApi:
            return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FlickrAPIKey)&tags=\("cooking")&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags,url_t"
        }
    }
}

enum RequestMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

let FlickrAPIKey = "2ed35a9f4fda03bc96e73dbd03602780"

