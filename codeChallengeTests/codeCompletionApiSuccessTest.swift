//
//  codeCompletionApiSuccessTest.swift
//  codeChallengeTests
//
//  Created by Nancy on 19/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import XCTest
@testable import codeChallenge
@testable import NetworkLayer

class codeCompletionApiSuccessTest: XCTestCase {
    var sut: URLSession!
    let networkMonitor = NetworkMonitor.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
      try XCTSkipUnless(
        networkMonitor.isReachable,
        "Network connectivity requires for the test.")

      let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2ed35a9f4fda03bc96e73dbd03602780&tags=cooking&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags,url_t"
      let url = URL(string: urlString)!
      let promise = expectation(description: "Status code: 200")

      let dataTask = sut.dataTask(with: url) { _, response, error in
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }

    // Asynchronous test: faster fail
    func testApiCallCompletes() throws {
      try XCTSkipUnless(
        networkMonitor.isReachable,
        "Network connectivity requires for the test."
      )

      let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2ed35a9f4fda03bc96e73dbd03602780&tags=cooking&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags,url_t"
      let url = URL(string: urlString)!
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      let dataTask = sut.dataTask(with: url) { _, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }

}
