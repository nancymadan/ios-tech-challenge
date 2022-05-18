//
//  PhotoViewModel.swift
//  codeChallenge
//
//  Created by Nancy on 17/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import UIKit
import NetworkLayer

class PhotoListingViewModel: NSObject {
    
    @objc
    var photos: NSArray = []
    var apiTaskLoader = ApiLoader(urlSession: URLSession.shared, networkMonitor: NetworkMonitor.shared)

    @objc
    func getAllPhotosList(completion: @escaping (Bool)->()) {
        let api = PhotosService()
        guard let request = api.makeRequest(from: nil, data: [:]) else {
            return
        }
        // api loader
        apiTaskLoader.loadApiRequest(requestData: request, type: PhotosModel.self) { [weak self] result, error in
            if let result = result,
               let self = self {
                self.photos = (result.photos?.photo?.compactMap({PhotosViewModel(model: $0)})) as? NSArray ?? []
                DispatchQueue.main.async {
                    self.sortBydate(latestFirst: true)
                    completion(true)
                }
            }
            
        }
    }
    
    @objc
    func sortBydate(latestFirst: Bool) {
        self.photos = (photos as? [PhotosViewModel] ?? []).sorted(by: latestFirst ? {$0.datetaken > $1.datetaken} : {$0.datetaken < $1.datetaken}) as NSArray
    }
    
}

class PhotosViewModel : NSObject {
    
    @objc
    let title: String
    @objc
    let photoDescription: NSAttributedString
    @objc
    let datetaken: String
    @objc
    var imageData: Data?
    let imageCache: NSCache<AnyObject, AnyObject>?
    let apiTaskLoader = ApiLoader(urlSession: URLSession.shared, networkMonitor: NetworkMonitor.shared)


    init(model: Photo) {
        imageCache = NSCache()
        title = model.title ?? ""
        photoDescription = (model.description?.content ?? "").htmlToAttributedString 
        datetaken = model.datetaken ?? ""
        imageData = nil
        super.init()
        getImageData(urlString: model.urlT)
    }
    
    @objc
    func getImageData(urlString: String?) {
        
        if let urlString = urlString as? NSString,
           let data = imageCache?.object(forKey: urlString) as? Data {
            self.imageData = data
            return
        }

         let api = ImageService()
        guard let urlString = urlString,
              let request = api.makeRequest(from: urlString, data: [:]) else {
             return
         }
         // api loader
         apiTaskLoader.loadApiRequest(requestData: request, type: Data.self) {[weak self] result, error in
             if let result = result,
                let self = self {
                 self.imageCache?.setObject(result as NSData, forKey: urlString as NSString)
                 self.imageData = result
             } else {
                 self?.imageData = nil
             }
         
         }
     }
}





