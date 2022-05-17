//
//  PhotosService.swift
//  codeChallenge
//
//  Created by Nancy on 17/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import Foundation
import NetworkLayer

struct PhotosService: APIHandler {
    func makeRequest(from urlString: String?, data: [String : Any]) -> Request? {
        guard let url = URL(string: (urlString == nil ? Apis.photoApi.getApiValue() : urlString) ?? "") else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        // set http method type
        urlRequest.httpMethod = RequestMethod.GET.rawValue
        // set body params
        set(parameters: data, urlRequest: &urlRequest)
        // prepares request (sets header params, any additional configurations)
        let request = RequestIntialiser(request: urlRequest)
        
        return request
    }
    
}

struct ImageService: APIHandler {
    func makeRequest(from urlString: String?, data: [String: Any]) -> Request? {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        // set http method type
        urlRequest.httpMethod = RequestMethod.GET.rawValue
        // set body params
        set(parameters: data, urlRequest: &urlRequest)
        // prepares request (sets header params, any additional configurations)
        let request = RequestIntialiser(request: urlRequest)
        
        return request
    }
    
}
