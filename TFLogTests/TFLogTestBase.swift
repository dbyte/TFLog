//
//  TFLogTestBase.swift
//  TFLogTests
//
//  Created by Tammo on 12.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest

class TFLogTestBase: XCTestCase {
    
    var timeout: TimeInterval!
    
    override class func setUp() {
        super.setUp()
        // This is the setUp() class method.
        // It is called before the FIRST test method begins.
        // Set up any overall initial state here.
    }
    
    override class func tearDown() {
        // This is the tearDown() class method.
        // It is called after ALL test methods complete.
        // Perform any overall cleanup here.
        super.tearDown()
    }

    override func setUp() {
        super.setUp()
        timeout = 3
    }

    override func tearDown() {
        timeout = 0
        super.tearDown()
    }

}
