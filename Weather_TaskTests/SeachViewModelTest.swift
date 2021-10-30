//
//  SeachViewModelTest.swift
//  Weather_TaskTests
//
//  Created by NowPayMacmini-1 on 11/4/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Weather_Task

class SeachViewModelTest: XCTestCase {
    
    var sut: SearchViewModel!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = SearchViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    
    func test_initailValueEqualNotNil() {
        XCTAssertNotNil(sut.locationDetailsModel)
    }
    
    func test_afterCallingNotEqualNil() {
        var forecastModel: CountryWeatherModel!
        let exp = expectation(description: "Loading location")
        let expObser = expectation(description: "Loading observation")
        sut.fetchCurrentLocationData() {
            exp.fulfill()
        }
        sut.locationDetailsModel.subscribe(onNext: { model in
            forecastModel = model
            expObser.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(forecastModel)
    }
}
