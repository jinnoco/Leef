//
//  LeefUITests.swift
//  LeefUITests
//
//  Created by J on 2021/11/16.
//

import XCTest

class LeefUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCTContext.runActivity(named: "launch app") { _ in
            app.launch()
        }
    }

    
    
    

}
