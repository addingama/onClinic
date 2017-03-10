//
//  UserModelTests.swift
//  onClinic
//
//  Created by MTMAC24 on 3/9/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import XCTest

@testable import onClinic

class UserModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserModelInitializationSucceeds() {
        let user = User(id: 1, name: "Addin", role: "Admin", token: "asdfajsdfasd")
        XCTAssertNotNil(user)
        XCTAssertEqual(user.name, "Addin")
    }
    
    func testUserModelInitializationFails() {
        let user = User(id: 1, name: "", role: "Unknown", token: "")
        XCTAssertNil(user)
    }
}
