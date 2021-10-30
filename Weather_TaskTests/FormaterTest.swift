//
//  FormaterTest.swift
//  Weather_TaskTests
//
//  Created by NowPayMacmini-1 on 11/4/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import XCTest
@testable import Weather_Task

class CODateFormatterTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func test_Formatting() {
        let date = CODateFormatter.slashSeparatorDateFormatter(input: "2020-11-04 09:59:39")
        XCTAssertEqual(date, "Wed 09:59")
    }
}
