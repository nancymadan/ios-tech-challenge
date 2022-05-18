//
//  codeChallengeStubTests.swift
//  codeChallengeTests
//
//  Created by Nancy on 19/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import XCTest
@testable import codeChallenge
@testable import NetworkLayer

class codeChallengeStubTests: XCTestCase {
    var sut: PhotoListingViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PhotoListingViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
 

    func testPhotoListingFromApiRequest() {
     guard let stubbedData = readLocalJSONFile(forName:"SampleData") else {
          return
      }
      let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2ed35a9f4fda03bc96e73dbd03602780&tags=cooking&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags,url_t"
      let url = URL(string: urlString)!
      let stubbedResponse = HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)
      let urlSessionStub = URLSessionStub (
        data: stubbedData,
        response: stubbedResponse,
        error: nil)
        let apiLoader = ApiLoader(urlSession: urlSessionStub, networkMonitor: .shared)
      let promise = expectation(description: "Completion handler invoked")

      // when
        sut.apiTaskLoader = apiLoader
        sut.getAllPhotosList { success in
            XCTAssertEqual(self.sut.photos.count, 2)
            promise.fulfill()

        }
      wait(for: [promise], timeout: 150)
        
    }

    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }

}
