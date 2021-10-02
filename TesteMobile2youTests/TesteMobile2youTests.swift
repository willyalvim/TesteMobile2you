//
//  TesteMobile2youTests.swift
//  TesteMobile2youTests
//
//  Created by Willy Alvim on 29/09/21.
//

import XCTest
@testable import TesteMobile2you

class TesteMobile2youTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Download movie data")
    
    func testGetData() {
       let vc =  ViewController()
        vc.getData{movieJson in
            XCTAssertNotNil(movieJson, "nulo")
            XCTAssertEqual(movieJson?.id, 550)
           
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
