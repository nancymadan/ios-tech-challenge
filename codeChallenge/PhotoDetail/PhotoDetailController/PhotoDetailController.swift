//
//  PhotoDetailController.swift
//  codeChallenge
//
//  Created by Nancy on 18/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import UIKit

class PhotoDetailController: UIViewController {
    private var photosViewModel: PhotosViewModel?
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var lblDescription: UILabel!
    @IBOutlet weak private var imgPhoto: UIImageView!
    
   @objc
    init(photoData: PhotosViewModel) {
        super.init(nibName: String(describing: PhotoDetailController.self),
                   bundle: nil)
        photosViewModel = photoData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }
    
    func setUpData() {
        lblTitle.text = photosViewModel?.title
        lblDescription.attributedText = photosViewModel?.photoDescription
        if let data = photosViewModel?.imageData {
        imgPhoto.image = UIImage(data: data)
        }
    }

}
