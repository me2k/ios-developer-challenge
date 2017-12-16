//
//  APITests.swift
//  ComicKitTests
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import XCTest
import PromiseKit
@testable import ComicKit

// NOTE: The larger test may fail as the Marvel API times out! Retry the tests and they are very likely to succeed.

class APITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //register the live api
        Core.register({ API.instance as APIProtocol })
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func retrieveComics(withOffset offset: Int, limit: Int) {
        let comicExpectation = self.expectation(description: "Download Comics")
        var localComics = [Comic]()
        firstly {
            return Core.api.comics.retrieveComics(offset, limit: limit)
        }.then { comics -> Void in
            debugPrint("\(comics.count) Comics downloaded")
            localComics = comics
            comicExpectation.fulfill()
        }.catch { error in
            debugPrint("Failed to retrieve comics: \(error.localizedDescription)")
            comicExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            if let error = error {
                XCTFail("Error retrieving comics: \(error)")
            }
            
            XCTAssertEqual(localComics.count, limit, "Comics count incorrect")
        }
    }
    
    func testRetrieveComics() {
        retrieveComics(withOffset: 0, limit: 20)
    }
    
    func testRetrieveComicsWithOffest() {
        retrieveComics(withOffset: 10, limit: 20)
    }
    
    func testRetrieveComicsLargeLimit() {
        retrieveComics(withOffset: 0, limit: 100)
    }
    
    func testRetrieveComicsLargeLimitOffset() {
        retrieveComics(withOffset: 200, limit: 100)
    }
}
