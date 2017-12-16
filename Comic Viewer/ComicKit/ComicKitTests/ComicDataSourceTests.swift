//
//  ComicDataSourceTests.swift
//  ComicKitTests
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import XCTest
@testable import ComicKit

class DelegateTestClass: DataSourceDelegate {
    
    var asyncExpectation: XCTestExpectation?
    var allAsyncExpectations: XCTestExpectation?
    var wasDelegateCalled = [Bool]()
    var callCount: Int = 0
    var callsCounted: Int = 0
    
    func incrementCall() {
        callsCounted = callsCounted + 1
        if callCount == callsCounted {
            allAsyncExpectations?.fulfill()
        }
    }
    
    func dataSourceDidUpdate(dataSource: DataSourceProtocol) {
        wasDelegateCalled.append(true)
        incrementCall()
        asyncExpectation?.fulfill()
    }
    
    func dataSourceDidStartUpdate(dataSource: DataSourceProtocol) {
        //do nothing here
    }
    
    func dataSourceDidFailToUpdate(error: Error?, httpCode: Int?, dataSource: DataSourceProtocol) {
        wasDelegateCalled.append(true)
        incrementCall()
        asyncExpectation?.fulfill()
    }
}

class DataSourceTests: XCTestCase {
    
    //MARK: Properties
    
    var dataSource: ComicDataSource!
    var delegateTestClass: DelegateTestClass!

    //MARK: Methods
    
    override func setUp() {
        super.setUp()
        
        //register the API
        Core.register({ API.instance as APIProtocol })
        
        dataSource = ComicDataSource()
        delegateTestClass = DelegateTestClass()
        dataSource.delegate = delegateTestClass

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func reloadDataSource(withReloads reloads: Int) {
        let allReloadsExpectation = self.expectation(description: "all reloads")
        
        delegateTestClass.allAsyncExpectations = allReloadsExpectation
        
        for _ in (0..<reloads) {
            self.reloadDataSource()
        }
        allReloadsExpectation.fulfill()
        
        waitForExpectations(timeout: 10.0 * TimeInterval(reloads)) { (error) in
            if let error = error {
                XCTFail("Error testing reload comics: \(error)")
            }
            guard !self.delegateTestClass.wasDelegateCalled.contains(false) else {
                XCTFail("delegate method not called")
                return
            }
            
            let total = reloads * self.dataSource.limit
            
            XCTAssertEqual(self.dataSource.items.count, total, "comics count incorrect")
            XCTAssertEqual(self.dataSource.viewModels.count, total, "comics view models count incorrect")
        }
    }
    
    func reloadDataSource() {
        let activeAsyncExpectation = self.expectation(description: "current reload")
        delegateTestClass.asyncExpectation = activeAsyncExpectation
        dataSource.reload()
        wait(for: [activeAsyncExpectation], timeout: 10.0)
        debugPrint("Downloaded Comics, total: \(dataSource.items.count) page: \(dataSource.page) offset: \(dataSource.offset)")
    }
    
    func testReload() {
        self.reloadDataSource(withReloads: 1)
    }
    
    func testReload2Pages() {
        self.reloadDataSource(withReloads: 2)
    }
    
    func testReload3Pages() {
        self.reloadDataSource(withReloads: 3)
    }
    
    func testReload4Pages() {
        self.reloadDataSource(withReloads: 4)
    }
}
