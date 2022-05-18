//
//  codeChallengeTests.swift
//  codeChallengeTests
//
//  Created by Nancy on 18/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import XCTest
@testable import codeChallenge
class codeChallengeTests: XCTestCase {
    
    var sut: PhotoListingViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PhotoListingViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func setSampleData() {
        let photo1 = Photo(title: "Green Plate",
                           description: Description(content: "PENTAX K-1 FF Mode 800 ISO Pentax DA 70mm F2.4 Limited"),
                           datetaken: "2022-04-16 12:02:11",
                           urlT: "https://live.staticflickr.com/65535/52082687261_d1c0e6a94f_t.jpg")
        let photo2 = Photo(title: "Making Violet Flower Simple Syrup",
                           description: Description(content: "May 12, 2022"),
                           datetaken: "2022-05-12 17:27:12",
                           urlT: "https://live.staticflickr.com/65535/52082687261_d1c0e6a94f_t.jpg")

        sut.photos = [PhotosViewModel(model: photo1),
                      PhotosViewModel(model: photo2)]
    }

    func testSortForDescreasingOrder() {
        setSampleData()
        sut.sortBydate(latestFirst: true)
        XCTAssertEqual((sut.photos as? [PhotosViewModel] ?? []).first?.datetaken, "2022-05-12 17:27:12", "Data is sorted with latest date taken first")
        
    }
    
    func testSortForIncreasingOrder() {
        setSampleData()
        sut.sortBydate(latestFirst: false)
        XCTAssertEqual((sut.photos as? [PhotosViewModel] ?? []).first?.datetaken, "2022-04-16 12:02:11", "Data is sorted with oldest date taken first")
        
    }
   

}
